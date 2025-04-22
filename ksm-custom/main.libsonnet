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
      '#new':
        d.fn(
          '`new` creates a new resource with a metric name prefix and the group, version and kind of the resource to scrape, the scraped metrics will include labels for the name and namespace.',
          args=[
            d.arg('prefix', d.T.string),
            d.arg('group', d.T.string),
            d.arg('version', d.T.string),
            d.arg('kind', d.T.string),
          ],
        ),
      new(prefix, group, version, kind):
        self.withMetricNamePrefix(prefix)
        + self.withNamespaceFromResource()
        + self.withGroupVersionKind(
          group,
          version,
          kind,
        ),

      '#withGroupVersionKind'::
        d.fn(
          '`withGroupVersionKind` sets the group, version and kind of the resource to scrape.',
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

      groupVersionKind+: {
        '#withPlural'::
          d.fn(
            |||
              `withPlural` adds the plural of the GroupVersionKind to a hidden field. It is not used by CustomResourceStateMetrics but can be used to generate PolicyRule objects.

              See `withCustomResourceStateMetrics()` on the kube-state-metrics library in this repository.
            |||,
            args=[
              d.arg('plural', d.T.string),
            ],
          ),
        withPlural(plural): {
          groupVersionKind+: {
            plural:: plural,
          },
        },
      },

      '#withNamespaceFromResource':
        d.fn(
          '`withNamespaceFromResource` gets the name and namespace labels from the resource metadata.'
        ),
      withNamespaceFromResource():
        resources.withLabelsFromPath({
          name: ['metadata', 'name'],
          namespace: ['metadata', 'namespace'],
        }),

      metrics+: {
        predefined+: {
          '#conditionStatus'::
            d.fn(
              |||
                `conditionStatus` provides a metric configuration to scrape CRs which expose status conditions with https://pkg.go.dev/k8s.io/apimachinery/pkg/apis/meta/v1#Condition

                Note that the HELP text needs to be unique within a CRSM config to avoid sanitization logic by KSM: https://github.com/kubernetes/kube-state-metrics/issues/2453 This is done by appending the GroupVersionKind to the HELP text.

                For example a resource with this status:

                ```yaml
                status:
                  conditions:
                    - lastTransitionTime: "2019-10-22T16:29:31Z"
                      status: "True"
                      type: Ready
                ```

                And a CRSM resource like this:

                ```jsonnet
                ksmCustom.new()
                + ksmCustom.withResources([
                  spec.resources.new(
                    'myprefix',
                    'myteam.io',
                    'v1',
                    'Foo',
                  )
                  + spec.resources.withMetrics([
                    spec.resources.metrics.predefined.conditionStatus(
                      'myteam.io',
                      'v1',
                      'Foo',
                    ),
                  ]),
                ])
                ```

                Would give a metric like this:

                ```
                myprefix_status{customresource_group="myteam.io", customresource_kind="Foo", customresource_version="v1", type="Ready"} 1.0
                ```

                Source of this idea: https://github.com/kubernetes/kube-state-metrics/blob/main/docs/metrics/extend/customresourcestate-metrics.md#example-for-status-conditions-on-kubernetes-controllers
              |||,
              args=[
                d.arg('group', d.T.string),
                d.arg('version', d.T.string),
                d.arg('kind', d.T.string),
              ]
            ),
          conditionStatus(group, version, kind):
            local metric = resources.metrics;
            metric.withName('status')
            + metric.withHelp('Status conditions for ' + std.join('/', [group, version, kind]))
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
    '#':: d.package.newSub('alerts', 'Generic alerts for use with Prometheus'),
    '#conditionStatus':: d.obj('Create alert rules for the metrics provided by `spec.metrics.predefined.conditionStatus`'),
    conditionStatus: {
      '#new':: d.fn(
        |||
          `new` creates a new alert rule.

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
            {{$labels.customresource_kind}} resource {{$labels.name}} is not %s with reason {{$labels.reason}}.
          ||| % type,
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

  crossplane:
    (import './crossplane_deprecated.libsonnet')
    + (import './crossplane.libsonnet'),
}
