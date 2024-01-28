local utils = import './utils.libsonnet';
local k = import 'github.com/grafana/jsonnet-libs/ksonnet-util/kausal.libsonnet';
local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

{
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
        name:: name,

        local container = k.core.v1.container,
        local containerPort = k.core.v1.containerPort,
        container::
          container.new('kube-state-metrics', image)
          + container.withArgs([
            '--port=8080',
            '--telemetry-host=0.0.0.0',
            '--telemetry-port=8081',
          ])
          + container.withPorts([
            containerPort.new('ksm', 8080),
            containerPort.new('self-metrics', 8081),
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
          + deployment.spec.template.spec.securityContext.withRunAsGroup(65534),

        policyRules:: [],
        rbac:
          (k + { _config+: { namespace: namespace } }).util.rbac(
            name,
            self.policyRules
          ),
      }
      // default to Kubernetes Policy Rules
      + self.withKubernetesWatchPolicyRules(),

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
      `withKubernetesWatchPolicyRules` configures a bunch of policy rules to watch many\n
      resources in Kubernetes.
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
    |||,
    args=[d.arg('customResourceStateMetrics', d.T.object)],
  ),
  withCustomResourceStateMetrics(customResourceStateMetrics):: {
    local definitions = [
      {
        group: resource.groupVersionKind.group,
        // FIXME: A policy rule expects the 'resources' name ('plural' from a CRD),
        // making it impossible to generate the policy rules directly from
        // customResourceStateMetrics.
        // A wildcard gives KSM access to all resources in this group, which is a stopgap
        // solution allowing us to move forward in testing this.
        resources: ['*'],
      }
      for resource in customResourceStateMetrics.spec.resources
    ],

    policyRules:: utils.createWatchRules(definitions),

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

  utils: (import './utils.libsonnet'),
}
