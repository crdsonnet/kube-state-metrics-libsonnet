local prometheusRules = import 'github.com/crdsonnet/prometheus-libsonnet/prometheusRules/main.libsonnet';
local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

(import './generated.libsonnet')
+ {
  '#'::
    d.pkg(
      name='ksm-custom',
      url='github.com/crdsonnet/ksm-custom-libsonnet/ksm-custom',
      help=|||
        `ksm-custom` can generate config for [Custom Resource State Metrics](https://github.com/kubernetes/kube-state-metrics/blob/main/docs/customresourcestate-metrics.md) from kube-state-metrics.
      |||,
      filename=std.thisFile,
    ),

  '#new':: d.fn('Initialize new CustomResourceStateMetrics object'),
  new(): {
    kind: 'CustomResourceStateMetrics',
  },

  spec+: {
    resources+: {
      local resources = self,
      new(prefix, group, version, kind):
        self.withMetricNamePrefix(prefix)
        + self.withGroupVersionKind(
          group,
          version,
          kind,
        ),

      '#withGroupVersionKind'::
        d.fn(
          'Set group, version and kind of the resource to scrape.',
          args=[
            d.arg('group', d.T.string),
            d.arg('version', d.T.string),
            d.arg('kind', d.T.string),
          ],
        ),
      withGroupVersionKind(group, version, kind):
        self.groupVersionKind.withGroup(group)
        + self.groupVersionKind.withVersion(version)
        + self.groupVersionKind.withKind(kind),

      labels: {
        fromNamespacedResource():
          resources.withLabelsFromPath({
            name: ['metadata', 'name'],
            namespace: ['metadata', 'namespace'],
          }),

        fromCrossplaneClaimLabels():
          resources.withLabelsFromPath({
            name: ['metadata', 'labels', 'crossplane.io/claim-name'],
            namespace: ['metadata', 'labels', 'crossplane.io/claim-namespace'],
          }),
      },

      metrics+: {
        common+: {
          '#conditionStatus'::
            d.fn(
              'Scrape CRs which expose status conditions according to https://pkg.go.dev/k8s.io/apimachinery/pkg/apis/meta/v1#Condition',
            ),
          conditionStatus():
            local metric = resources.metrics;
            metric.withName('status')
            + metric.withHelp('Status conditions')
            + metric.each.withType('Gauge')
            + metric.each.gauge.withPath(['status', 'conditions'])
            + metric.each.gauge.withLabelsFromPath({
              type: ['type'],
              reason: ['reason'],
            })
            // "true" mapped to 1.0
            // "false" and "unknown" are mapped to 0.0
            + metric.each.gauge.withValueFrom(['status']),
        },
      },
    },
  },

  alerts: {
    conditionStatus: {
      '#new':: d.fn(
        |||
          `new` creates a new alert rule for the metrics provided by `spec.metrics.common.conditionStatus`

          Arguments:
          - `prefix`: metricNamePrefix that is used to create the CRSM resource
          - `type`: type of condition to alert upon
          - `reasonFilter`: prometheus label filter, this may be useful as some operations take longer or have a different severity
        |||,
        args=[
          d.arg('prefix', d.T.string),
          d.arg('type', d.T.string),
          d.arg('reasonFilter', d.T.string, default='reason=~".*"'),
        ],
      ),
      new(prefix, type, reasonFilter='reason=~".*"'):
        prometheusRules.rule.newAlert(
          'ResourceNot%s' % type,
          |||
            count by (customresource_kind, name, namespace, reason) (%s_status{type="%s", %s}==0)
          ||| % [prefix, type, reasonFilter]
        )
        + prometheusRules.rule.withLabels({ severity: 'warning' })
        + prometheusRules.rule.withFor('15m')
        + prometheusRules.rule.withAnnotations({
          message: |||
            {{$labels.customresource_kind}} resource {{$labels.name}} is not {{$labels.type}} with reason {{$labels.reason}}.
          |||,
        }),

      '#withSeverity':: d.fn(
        '`withSeverity` changes the severity of the alert',
        args=[d.arg('severity', d.T.string)],
      ),
      withSeverity(severity):
        prometheusRules.rule.withLabelsMixin({ severity: severity }),

      '#withPendingFor':: d.fn(
        '`withPendingFor` changes how long the alert can stay pending',
        args=[d.arg('pendingFor', d.T.string)],
      ),
      withPendingFor(pendingFor):
        prometheusRules.rule.withFor(pendingFor),

      '#withMessage':: d.fn(
        '`withMessage` can be used add additional information to the alert message annotation',
        args=[d.arg('message', d.T.string)],
      ),
      withMessage(message):
        prometheusRules.rule.withAnnotationsMixin({
          message+: '\n' + message,
        }),
    },
  },

  crossplane: (import './crossplane.libsonnet'),
}
