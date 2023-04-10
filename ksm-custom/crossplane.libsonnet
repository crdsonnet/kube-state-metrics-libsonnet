local ksmCustom = import './main.libsonnet';
local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

{
  '#':: d.package.newSub('crossplane', 'Helper functions related to Crossplane'),

  '#statusResource':: d.fn(
    |||
      This is a first attempt at gathering metrics for Crossplane resources using
      CustomResourceStateMetrics. This may change heavily, contributions and input
      much appreciated.

      ```jsonnet
      local definitions = [
        {
          group: 'database.crossplane.grafana.net',
          kind: 'MySQLInstance',
          version: 'v1alpha1',
        },
        {
          group: 'database.crossplane.grafana.net',
          kind: 'PostgreSQLInstance',
          version: 'v1alpha1',
        },
      ];

      ksmCustom.new()
      + ksmCustom.spec.withResources([
        statusResource(def.group, def.version, def.kind)
        for def in definitions
      ])
      ```
    |||,
    args=[
      d.arg('group', d.T.string),
      d.arg('version', d.T.string),
      d.arg('kind', d.T.string),
    ],
  ),
  statusResource(group, version, kind):
    local resource = ksmCustom.spec.resources;
    local metric = ksmCustom.spec.resources.metrics;

    local status = [
      'True',
      'False',
    ];

    // Source: https://github.com/crossplane/crossplane-runtime/blob/v0.19.0/apis/common/v1/condition.go
    local conditions = {
      Synced: [
        'ReconcileSuccess',
        'ReconcileError',
        'ReconcilePaused',
      ],
      Ready: [
        'Available',
        'Unavailable',
        'Creating',
        'Deleting',
      ],
    };

    resource.withGroupVersionKind(
      group,
      version,
      kind,
    )
    + resource.withMetricNamePrefix('crossplane_')
    + resource.withLabelsFromPath({
      name: ['metadata', 'name'],
      namespace: ['metadata', 'namespace'],
    })
    + resource.withMetrics(
      [
        metric.withName('status_%s_reason' % std.asciiLower(k))
        + metric.withHelp('Conditions for %s - Reason' % k)
        + metric.each.withType('StateSet')
        + metric.each.stateSet.withLabelName('reason')
        + metric.each.stateSet.withPath([
          'status',
          'conditions',
          '[type=%s]' % k,
          'reason',
        ])
        + metric.each.stateSet.withList(conditions[k])
        for k in std.objectFields(conditions)
      ]
      + [
        metric.withName('status_%s' % std.asciiLower(k))
        + metric.withHelp('Conditions for %s - Status' % k)
        + metric.each.withType('StateSet')
        + metric.each.stateSet.withLabelName('status')
        + metric.each.stateSet.withPath([
          'status',
          'conditions',
          '[type=%s]' % k,
          'status',
        ])
        + metric.each.stateSet.withList(status)
        for k in std.objectFields(conditions)
      ]
    ),
}
