local utils = import './utils.libsonnet';
local config = import 'github.com/crdsonnet/kube-state-metrics-libsonnet/ksm-config/main.libsonnet';
local k = import 'github.com/grafana/jsonnet-libs/ksonnet-util/kausal.libsonnet';
local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

{
  local root = self,
  local telemetryPortName = 'self-metrics',
  local ksmPortName = 'ksm',

  '#':: d.package.new(
    'kubeStateMetrics',
    help=|||
      `kube-state-metrics` provides the manifests to configure kube-state-metrics
      instances on Kubernetes.

      This library is based on https://github.com/grafana/jsonnet-libs/tree/master/kube-state-metrics
    |||,
    url='github.com/crdsonnet/kube-state-metrics-libsonnet/kube-state-metrics',
    filename=std.thisFile,
  ),

  '#new':: d.fn(
    |||
      `new` provides initial manifest to deploy kube-state-metrics. By default it will
      configure a ClusterRole with policy rules list/watch a bunch of Kubernetes
      resources. The `namespace` is necessary to know up front provide a service account.
    |||,
    args=[
      d.arg('namespace', d.T.string),
      d.arg('name', d.T.string, default='kube-state-metrics'),
      d.arg('image', d.T.string, default='registry.k8s.io/kube-state-metrics/kube-state-metrics:v2.8.2'),
    ]
  ),
  new(
    namespace,
    name='kube-state-metrics',
    image='registry.k8s.io/kube-state-metrics/kube-state-metrics:v2.8.2',
  ):: {
        local this = self,
        name:: name,

        config::
          config.withPort(8080)
          + config.withTelemetryHost('0.0.0.0')
          + config.withTelemetryPort(8081)
          + (
            local defaultResources = utils.getResourcesFromRules(root.withKubernetesWatchPolicyRules().policyRules);
            local resources = utils.getResourcesFromRules(this.policyRules);
            // Only include 'resources' when different from the default set
            if resources != defaultResources
            then config.withResources(resources)
            else {}
          ),
        config_file:: 'config.yml',
        config_path:: '/etc/kube-state-metrics',

        priority_class:: '',

        local configMap = k.core.v1.configMap,
        config_map:
          configMap.new('%s-config' % this.name)
          + configMap.withData({
            [this.config_file]:
              k.util.manifestYaml(
                this.config
              ),
          }),

        local container = k.core.v1.container,
        local containerPort = k.core.v1.containerPort,
        local envVar = k.core.v1.envVar,
        container::
          container.new('kube-state-metrics', image)
          + container.withArgs([
            '--config=%s' % std.join('/', [
              self.config_path,
              self.config_file,
            ]),
          ])
          + container.withPorts([
            containerPort.new(ksmPortName, self.config.port),
            containerPort.new(telemetryPortName, self.config.telemetry_port),
          ])
          + k.util.resourcesRequests('50m', '50Mi')
          + k.util.resourcesLimits('250m', '150Mi'),
        local deployment = k.apps.v1.deployment,
        deployment:
          deployment.new(name, 1, [self.container])
          + deployment.spec.template.spec.withServiceAccountName(
            self.rbac.service_account.metadata.name
          )
          + deployment.spec.template.spec.securityContext.withRunAsUser(65534)
          + deployment.spec.template.spec.securityContext.withRunAsGroup(65534)
          + deployment.configMapVolumeMount(self.config_map, self.config_path)
          + (
            if self.priority_class != ''
            then deployment.spec.template.spec.withPriorityClassName(self.priority_class)
            else {}
          ),

        // Add hidden statefulset to allow mixins on both
        statefulset:: {},

        policyRules:: [],
        rbac:
          (k { _config+: { namespace: namespace } }).util.rbac(
            name,
            self.policyRules
          ),
      }
      // default to Kubernetes Policy Rules
      + self.withKubernetesWatchPolicyRules(),

  '#withAutomaticSharding':: d.fn(
    |||
      `withAutomaticSharding` configures kube-state-metrics with automatic sharding enabled, this will replace the Deployment with a Statefulset.

      This mode is incompatible with `withCustomResourceStateMetrics()`
    |||,
    [d.arg('replicas', d.T.number, default=2)],
  ),
  withAutomaticSharding(replicas=2):: {
    local this = self,
    replicas:: replicas,
    config+: config.withTotalShards(this.replicas),
    config_file:: '$(POD_NAME).yml',

    local configMap = k.core.v1.configMap,
    config_map:
      configMap.new('%s-config' % this.name)
      + configMap.withData({
        ['%s-%s.yml' % [this.name, i]]:
          k.util.manifestYaml(
            this.config
            + config.withShard(i)
          )
        for i in std.range(0, this.replicas - 1)
      }),

    local container = k.core.v1.container,
    container+:
      container.withArgs([
        '--config=%s' % std.join('/', [self.config_path, self.config_file]),
      ])
      + container.withEnvMixin([
        k.core.v1.envVar.fromFieldPath('POD_NAME', 'metadata.name'),
      ]),

    // Hide deployment in favor of statefulset
    deployment:: super.deployment,

    local statefulSet = k.apps.v1.statefulSet,
    statefulset:::
      statefulSet.new(this.name, self.replicas, [self.container])
      + statefulSet.spec.withServiceName(this.name)
      + statefulSet.spec.template.spec.withServiceAccountName(
        self.rbac.service_account.metadata.name
      )
      + statefulSet.spec.template.spec.securityContext.withRunAsUser(65534)
      + statefulSet.spec.template.spec.securityContext.withRunAsGroup(65534)
      + statefulSet.configMapVolumeMount(self.config_map, self.config_path)
      + statefulSet.spec.template.spec.affinity.podAntiAffinity.withRequiredDuringSchedulingIgnoredDuringExecution(
        k.core.v1.podAffinityTerm.withTopologyKey('kubernetes.io/hostname')
        + k.core.v1.podAffinityTerm.labelSelector.withMatchLabels({
          name: this.name,
        })
      )
      + (
        if self.priority_class != ''
        then statefulSet.spec.template.spec.withPriorityClassName(self.priority_class)
        else {}
      ),


    local podDisruptionBudget = k.policy.v1.podDisruptionBudget,
    pdb:
      podDisruptionBudget.new(this.name)
      + podDisruptionBudget.metadata.withLabels({ name: '%s-pdb' % this.name })
      + podDisruptionBudget.spec.selector.withMatchLabels({ name: this.name })
      + podDisruptionBudget.spec.withMaxUnavailable(1),
  },

  '#withReplicas':: d.fn(
    |||
      `withReplicas` sets the replicas, only applies to automatic sharding.
    |||,
    [d.arg('replicas', d.T.number)],
  ),
  withReplicas(replicas): {
    replicas:: replicas,
  },

  '#withPriorityClass':: d.fn(
    |||
      `withPriorityClass` sets the priority class name for the workload.
    |||,
    [d.arg('priorityClassName', d.T.string)],
  ),
  withPriorityClass(priorityClassName):: {
    priority_class:: priorityClassName,
  },

  '#withMetricLabelsAllowList':: d.fn(
    |||
      `withMetricLabelsAllowList` configures a list of additional Kubernetes label keys that will be used in the resource' labels metric.

      `allowList` looks like this:

      ```jsonnet
      {
          // Structure:
          //'<plural_resourcename>': [
          //  '<labelname1>',
          //  '<labelname2>',
          //],

          // Example:
          nodes: [
            'cloud.google.com/gke-nodepool',
            'eks.amazonaws.com/nodegroup',
          ],
      }
      ```
    |||,
    [d.arg('allowList', d.T.object)],
  ),
  withMetricLabelsAllowList(allowList):: {
    config+:: config.withLabelsAllowList(allowList),
  },

  '#withMetricAnnotationsAllowList':: d.fn(
    |||
      `withMetricAnnotationsAllowList` configures a list of Kubernetes annotations keys that will be used in the resource' labels metric.

      `allowList` looks like this:

      ```jsonnet
      {
          // Structure:
          //'<plural_resourcename>': [
          //  '<labelname1>',
          //  '<labelname2>',
          //],

          // Example:
          nodes: [
            'container.googleapis.com/instance_id',
          ],
      }
      ```
    |||,
    [d.arg('allowList', d.T.object)],
  ),
  withMetricAnnotationsAllowList(allowList):: {
    config+:: config.withAnnotationsAllowList(allowList),
  },

  '#withPolicyRules':: d.fn(
    '`withPolicyRules` allows to configure an alternate set of policy rules.',
    args=[d.arg('rules', d.T.array)]
  ),
  withPolicyRules(rules):: {
    policyRules:: rules,
  },

  '#withPolicyRulesMixin':: d.fn(
    '`withPolicyRulesMixin` allows to additional policy rules.',
    args=[d.arg('rules', d.T.array)]
  ),
  withPolicyRulesMixin(rules):: {
    policyRules+:: rules,
  },

  '#withKubernetesWatchPolicyRules':: d.fn(
    |||
      `withKubernetesWatchPolicyRules` configures a bunch of policy rules to watch many resources in Kubernetes.
    |||,
  ),
  withKubernetesWatchPolicyRules()::
    local definitions = [
      {
        group: '',
        resources: [
          'configmaps',
          'secrets',
          'nodes',
          'pods',
          'services',
          'resourcequotas',
          'replicationcontrollers',
          'limitranges',
          'persistentvolumeclaims',
          'persistentvolumes',
          'namespaces',
          'endpoints',
        ],
      },
      {
        group: 'apps',
        resources: [
          'daemonsets',
          'deployments',
          'replicasets',
          'statefulsets',
        ],
      },
      {
        group: 'batch',
        resources: [
          'cronjobs',
          'jobs',
        ],
      },
      {
        group: 'discovery.k8s.io',
        resources: ['endpointslices'],
      },
      {
        group: 'autoscaling',
        resources: ['horizontalpodautoscalers'],
      },
      {
        group: 'policy',
        resources: ['poddisruptionbudgets'],
      },
      {
        group: 'certificates.k8s.io',
        resources: ['certificatesigningrequests'],
      },
      {
        group: 'storage.k8s.io',
        resources: [
          'storageclasses',
          'volumeattachments',
        ],
      },
      {
        group: 'admissionregistration.k8s.io',
        resources: [
          'mutatingwebhookconfigurations',
          'validatingwebhookconfigurations',
        ],
      },
      {
        group: 'networking.k8s.io',
        resources: [
          'networkpolicies',
          'ingresses',
        ],
      },
      {
        group: 'coordination.k8s.io',
        resources: ['leases'],
      },
    ];

    self.withPolicyRulesMixin(utils.createWatchRules(definitions)),

  '#withServiceAccountMetrics':: d.fn(
    |||
      `withServiceAccountMetrics` enables scraping [ServiceAccount metrics](https://github.com/kubernetes/kube-state-metrics/blob/main/docs/metrics/auth/serviceaccount-metrics.md).
    |||,
    args=[
      d.arg('metrics', d.T.array, default=['kube_serviceaccount_info']),
      d.arg('annotationsAllowList', d.T.array, default=[]),
      d.arg('labelsAllowList', d.T.array, default=[]),
    ]
  ),
  withServiceAccountMetrics(
    metrics=['kube_serviceaccount_info'],
    annotationsAllowList=[],
    labelsAllowList=[],
  )::
    self.withPolicyRulesMixin(
      utils.createWatchRules([{
        group: '',
        resources: ['serviceaccounts'],
      }])
    )
    + {
      config+::
        config.withMetricOptInListMixin(metrics)
        + (if annotationsAllowList != []
           then
             config.withAnnotationsAllowListMixin({
               serviceaccounts+: annotationsAllowList,
             })
           else {})
        + (if labelsAllowList != []
           then
             config.withLabelsAllowListMixin({
               serviceaccounts+: labelsAllowList,
             })
           else {}),
    },

  '#withKubeRBACProxyPolicyRules':: d.fn(
    |||
      `withKubeRBACProxyPolicyRules` configures an additional policy rule for
      subjectAccessReview, according to the Helm chart this is used for kube-rbac-proxy
      but it is also included in the kube-state-metrics example without additional
      context, so it might not be necessary.
    |||,
  ),
  withKubeRBACProxyPolicyRules()::
    self.withPolicyRulesMixin(
      local policyRule = k.rbac.v1.policyRule;
      [
        policyRule.withApiGroups(['authorization.k8s.io'])
        + policyRule.withResources(['subjectaccessreviews'])
        + policyRule.withVerbs(['create']),
      ],
    ),

  '#withCustomResourceStateMetrics':: d.fn(
    |||
      `withCustomResourceStateMetrics` reconfigures kube-state-metrics to run in
      'custom-resource-state-only' mode. It will then only collect metrics as provided by
      the `customResourceStateMetrics` object. Policy rules will be generated based on
      this object.

      Other modes such as automatic sharding are incompatible with this mode.
    |||,
    args=[d.arg('customResourceStateMetrics', d.T.object)],
  ),
  withCustomResourceStateMetrics(customResourceStateMetrics):: {
    local definitions = [
      {
        group: resource.groupVersionKind.group,
        // NOTE: A policy rule expects the 'resources' name ('plural' from a CRD),
        // making it impossible to generate the policy rules directly from customResourceStateMetrics.
        // A wildcard gives KSM access to all resources in this group, which is a stopgap solution to make this working.
        // The 'plural' field is generally not part of the CustomResourceStateMetrics object but it can be added by calling `resource.groupVersionKind.withPlural()` on th ksmCustom library in this repository.
        resources: [std.get(resource.groupVersionKind, 'plural', '*')],
      }
      for resource in customResourceStateMetrics.spec.resources
    ],


    // kube-state-metrics needs list and watch permissions granted to customresourcedefinitions.apiextensions.k8s.io to gather metrics from custom resources.
    local crdrule = {
      group: 'apiextensions.k8s.io',
      resources: ['customresourcedefinitions'],
    },

    // remove `resources` from config as it is dynamic when using CRSM
    config:: std.mergePatch(super.config, { resources: null }),

    policyRules:: utils.createWatchRules(definitions + [crdrule]),

    CRSMConfigMap:
      k.core.v1.configMap.new(self.name, {
        'custommetrics.yaml': std.manifestYamlDoc(customResourceStateMetrics, true),
      }),

    local container = k.core.v1.container,
    container+:
      container.withArgsMixin([
        '--custom-resource-state-only',
        '--custom-resource-state-config-file=/crsmconfig/custommetrics.yaml',
      ]),

    local deployment = k.apps.v1.deployment,
    deployment+:
      deployment.configMapVolumeMount(self.CRSMConfigMap, '/crsmconfig'),
  },
  '#withReadinessProbe':: d.fn(
    |||
      `withReadinessProbe` configures a readiness probe for the container.
    |||,
  ),
  withReadinessProbe(port=telemetryPortName, failureThreshold=3, periodSeconds=10, successThreshold=1, timeoutSeconds=5, initialDelaySeconds=5, path='/readyz'):: {
    local container = k.core.v1.container,
    container+: container.readinessProbe.withFailureThreshold(failureThreshold)
                + container.readinessProbe.httpGet.withPath(path)
                + container.readinessProbe.httpGet.withPort(port)
                + container.readinessProbe.withInitialDelaySeconds(initialDelaySeconds)
                + container.readinessProbe.withTimeoutSeconds(timeoutSeconds)
                + container.readinessProbe.withPeriodSeconds(periodSeconds)
                + container.readinessProbe.withSuccessThreshold(successThreshold),
  },
  '#withLivenessProbe':: d.fn(
    |||
      `withLivenessProbe` configures a liveness probe for the container.
    |||,
  ),
  withLivenessProbe(port=ksmPortName, failureThreshold=3, periodSeconds=10, successThreshold=1, timeoutSeconds=5, initialDelaySeconds=5, path='/livez'):: {
    local container = k.core.v1.container,
    container+: container.livenessProbe.withFailureThreshold(failureThreshold)
                + container.livenessProbe.httpGet.withPath(path)
                + container.livenessProbe.httpGet.withPort(port)
                + container.livenessProbe.withInitialDelaySeconds(initialDelaySeconds)
                + container.livenessProbe.withTimeoutSeconds(timeoutSeconds)
                + container.livenessProbe.withPeriodSeconds(periodSeconds)
                + container.livenessProbe.withSuccessThreshold(successThreshold),
  },
  withProbes()::
    root.withLivenessProbe()
    + root.withReadinessProbe(),
  utils: utils,
}
