local ksmCustom = import './main.libsonnet';
local prometheusRules = import 'github.com/crdsonnet/prometheus-libsonnet/prometheusRules/main.libsonnet';
local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

{
  local root = self,

  '#':: d.package.newSub('crossplane', 'Helper functions related to Crossplane'),

  '#statusResource':: d.fn(
    |||
      This is a first attempt at gathering metrics for Crossplane resources using
      CustomResourceStateMetrics. This may change heavily, contributions and input
      much appreciated.

      ```jsonnet
      local definitions = [
        {
          group: 'database.crossplane.example.org',
          kind: 'MySQLInstance',
          version: 'v1alpha1',
        },
        {
          group: 'database.crossplane.example.org',
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

      Example of the metrics:

      ```
      %s
      ```
    ||| % (importstr './exampleOutput/statusResource'),
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

    local conditions = [
      'Synced',
      'Ready',
    ];

    resource.withGroupVersionKind(
      group,
      version,
      kind,
    )
    + resource.withMetricNamePrefix('crossplane')
    + resource.withLabelsFromPath({
      name: ['metadata', 'name'],
      namespace: ['metadata', 'namespace'],
    })
    + resource.withMetrics(
      [
        metric.withName('status_%s_reason' % std.asciiLower(k))
        + metric.withHelp('Reason for status type %s' % k)
        + metric.each.withType('Info')
        + metric.each.info.withLabelsFromPath({
          reason: [
            'status',
            'conditions',
            '[type=%s]' % k,
            'reason',
          ],
        })
        for k in conditions
      ]
      + [
        metric.withName('status_%s' % std.asciiLower(k))
        + metric.withHelp('Status conditions for type %s' % k)
        + metric.each.withType('StateSet')
        + metric.each.stateSet.withLabelName('status')
        + metric.each.stateSet.withPath([
          'status',
          'conditions',
          '[type=%s]' % k,
          'status',
        ])
        + metric.each.stateSet.withList(status)
        for k in conditions
      ]
    ),

  '#statusResourceAlerts':: d.fn(
    |||
      `statusResourceAlerts` provides a set of alerts for the metrics provided by `statusResource`

      The output of this function can be used as a prometheus monitoring mixin.
    |||,
  ),
  statusResourceAlerts(): {
    prometheusAlerts+:
      prometheusRules.withGroupsMixin([
        prometheusRules.group.new(
          'crossplane',
          [
            // Differentiate between reasons as Create/Delete operations may take a while
            root.alerts.claimNotReadyAlert('reason=~"(Creating|Deleting)"', '1h'),
            root.alerts.claimNotReadyAlert('reason!~"(Creating|Deleting)"', '15m'),
            root.alerts.claimNotSyncedAlert('15m'),
          ]
        ),
      ]),
  },

  alerts: {
    '#claimNotReadyAlert':: d.fn(
      |||
        `claimNotReadyAlert` provides an alert for metrics provided by `statusResource`

         It might be useful to create separate alerts for different `reason`, for example
         Create/Delete operations may take a while and should only alert when they are
         stuck.
      |||,
      args=[
        d.arg(
          'reasonFilter',
          d.T.string,
          default='reason=~".*"',
        ),
        d.arg(
          'pendingFor',
          d.T.string,
          default='15m'
        ),
      ],
    ),
    claimNotReadyAlert(reason='reason=~".*"', pendingFor='15m'):
      prometheusRules.rule.newAlert(
        'CrossplaneClaimNotReady',
        |||
          sum by (customresource_kind, name, namespace, cluster, status) (crossplane_status_ready{status="False"}==1)
          * on (customresource_kind, name, namespace, cluster) group_left (reason) (crossplane_status_ready_reason{reason=~"%s"}==1)
        ||| % reason
      )
      + prometheusRules.rule.withFor(pendingFor)
      + prometheusRules.rule.withAnnotations({
        // Source: https://github.com/crossplane/crossplane-runtime/blob/v0.19.0/apis/common/v1/condition.go
        message: |||
          {{$labels.customresource_kind}} Claim {{$labels.name}} is not in a ready state with reason {{$labels.reason}}.

          Common reasons for not being ready:
            Creating: resource is currently being created.
            Deleting: resource is currently being deleted.
            Unavailable: resource is not currently available for use. Unavailable should be
              set only when Crossplane expects the resource to be available but knows it is
              not, for example because its API reports it is unhealthy.
        |||,
      }),

    '#claimNotSyncedAlert':: d.fn(
      '`claimNotSyncedAlert` provides an alert for metrics provided by `statusResource`',
      args=[d.arg('pendingFor', d.T.string, default='15m')],
    ),
    claimNotSyncedAlert(pendingFor='15m'):
      prometheusRules.rule.newAlert(
        'CrossplaneClaimNotSynced',
        |||
          sum by (customresource_kind, name, namespace, cluster, status) (crossplane_status_synced{status="False"}==1)
          * on (customresource_kind, name, namespace, cluster) group_left (reason) (crossplane_status_synced_reason==1)
        |||
      )
      + prometheusRules.rule.withFor(pendingFor)
      + prometheusRules.rule.withAnnotations({
        // Source: https://github.com/crossplane/crossplane-runtime/blob/v0.19.0/apis/common/v1/condition.go
        message: |||
          {{$labels.customresource_kind}} Claim {{$labels.name}} is not in a synced state with reason {{$labels.reason}}.

          Common reasons for not being synced:
            ReconcileError: Crossplane encountered an error while reconciling the resource.
              This could mean Crossplane was unable to update the resource to reflect its
              desired state, or that Crossplane was unable to determine the current actual
              state of the resource.
            ReconcilePaused: reconciliation on the managed resource is paused via the pause
              annotation.
        |||,
      }),
  },
}
