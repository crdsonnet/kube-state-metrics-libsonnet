local prometheusRules = import 'github.com/crdsonnet/prometheus-libsonnet/prometheusRules/main.libsonnet';
local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

local ksmCustom = import './main.libsonnet';
local resource = ksmCustom.spec.resources;

{
  local root = self,

  stateMetrics: {
    '#':: d.package.newSub('stateMetrics', 'Provide metrics and alerts to gather stateMetrics for Crossplane resources.'),
    local metricNamePrefix = 'crossplane_condition',
    '#new':: d.fn(
      |||
        Generate a new CustomResourceStateMetrics object from an array of GroupVersionKind tuples.

        ```jsonnet
        local gvks = [
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

        ksmCustom.crossplane.stateMetrics.new(gvks)
        ```
      |||,
      args=[
        d.arg('gvks', d.T.array),
      ],
    ),
    new(gvks):
      local sorted =
        std.sort(
          gvks,
          function(obj) '%(group)s#%(version)s#%(kind)s' % obj
        );

      ksmCustom.new()
      + ksmCustom.spec.withResources([
        resource.new(
          metricNamePrefix,
          gvk.group,
          gvk.version,
          gvk.kind,
        )
        + resource.withMetrics([
          resource.metrics.predefined.conditionStatus(
            gvk.group,
            gvk.version,
            gvk.kind,
          ),
        ])
        for gvk in sorted
      ]),

    '#withNamespaceFromClaimLabels':
      d.fn(
        |||
          `withNamespaceFromClaimLabels` gets the name and namespace labels from the crossplane.io/claim-{name,namespace} labels. This is particularly useful when monitoring Managed Resources that were created by a Composition.
        |||
      ),
    withNamespaceFromClaimLabels(): {
      spec+: {
        resources:
          std.map(
            function(r)
              r + resource.withLabelsFromPath({
                name: ['metadata', 'labels', 'crossplane.io/claim-name'],
                namespace: ['metadata', 'labels', 'crossplane.io/claim-namespace'],
              }),
            super.resources
          ),
      },
    },

    alerts: {
      '#predefined':: d.fn(
        |||
          `predefined` provides a set of alerts for crossplane.stateMetrics.

          The output of this function can be used as a prometheus monitoring mixin.
        |||,
      ),
      predefined(): {
        prometheusAlerts+:
          prometheusRules.withGroupsMixin([
            prometheusRules.group.new(
              metricNamePrefix,
              [
                // Differentiate between reasons as Create/Delete operations may take a while
                root.alerts.claimNotReadyAlert('reason=~"(Creating|Deleting)"', '1h'),
                root.alerts.claimNotReadyAlert('reason!~"(Creating|Deleting)"', '15m'),

                root.alerts.claimNotSyncedAlert('15m'),
              ]
            ),
          ]),
      },

      claim: {
        '#claimNotReadyAlert':: d.fn(
          |||
            `claimNotReadyAlert` provides an alert for crossplane.stateMetrics, it'll fire when the resource is unable to become Ready.

            It might be useful to create separate alerts for different `reason`, for example Create/Delete operations may take a while and should only alert when they are stuck.
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
              default='15m',
            ),
            d.arg(
              'severity',
              d.T.string,
              default='warning',
            ),
          ],
        ),
        claimNotReadyAlert(reason='reason=~".*"', pendingFor='15m', severity='warning'):
          ksmCustom.alerts.conditionStatus.new(metricNamePrefix, 'Ready', reason)
          + ksmCustom.alerts.conditionStatus.withPendingFor(pendingFor)
          + ksmCustom.alerts.conditionStatus.withSeverity(severity)
          + ksmCustom.alerts.conditionStatus.withMessage(
            // Source: https://github.com/crossplane/crossplane-runtime/blob/v0.19.0/apis/common/v1/condition.go
            |||
              Common reasons for not being ready:
                Creating: resource is currently being created.
                Deleting: resource is currently being deleted.
                Unavailable: resource is not currently available for use. Unavailable should be
                  set only when Crossplane expects the resource to be available but knows it is
                  not, for example because its API reports it is unhealthy.
            |||,
          ),

        '#claimNotSyncedAlert':: d.fn(
          "`claimNotSyncedAlert` provides an alert for crossplane.stateMetrics, it'll fire when the resource is unable to be Synced.",
          args=[
            d.arg('pendingFor', d.T.string, default='15m'),
            d.arg('severity', d.T.string, default='warning'),
          ],
        ),
        claimNotSyncedAlert(pendingFor='15m', severity='warning'):
          ksmCustom.alerts.conditionStatus.new(metricNamePrefix, 'Synced')
          + ksmCustom.alerts.conditionStatus.withPendingFor(pendingFor)
          + ksmCustom.alerts.conditionStatus.withSeverity(severity)
          + ksmCustom.alerts.conditionStatus.withMessage(
            // Source: https://github.com/crossplane/crossplane-runtime/blob/v0.19.0/apis/common/v1/condition.go
            |||
              Common reasons for not being synced:
                ReconcileError: Crossplane encountered an error while reconciling the resource.
                  This could mean Crossplane was unable to update the resource to reflect its
                  desired state, or that Crossplane was unable to determine the current actual
                  state of the resource.
                ReconcilePaused: reconciliation on the managed resource is paused via the pause
                  annotation.
            |||,
          ),
      },
    },
  },
}
