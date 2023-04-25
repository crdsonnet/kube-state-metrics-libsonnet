# crossplane

Helper functions related to Crossplane

## Index

* [`fn statusResource(group, version, kind)`](#fn-statusresource)
* [`fn statusResourceAlerts()`](#fn-statusresourcealerts)
* [`obj alerts`](#obj-alerts)
  * [`fn claimNotReadyAlert(reason='.*', pendingFor='15m')`](#fn-alertsclaimnotreadyalert)
  * [`fn claimNotSyncedAlert(pendingFor='15m')`](#fn-alertsclaimnotsyncedalert)

## Fields

### fn statusResource

```ts
statusResource(group, version, kind)
```

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
# HELP crossplane_status_ready_reason Conditions for Ready - Reason
# TYPE crossplane_status_ready_reason gauge
crossplane_status_ready_reason{group="database.crossplane.example.org",kind="MySQLInstance",name="my-application-db",namespace="my-application",reason="Available",version="v1alpha1"} 1
crossplane_status_ready_reason{group="database.crossplane.example.org",kind="MySQLInstance",name="my-application-db",namespace="my-application",reason="Creating",version="v1alpha1"} 0
crossplane_status_ready_reason{group="database.crossplane.example.org",kind="MySQLInstance",name="my-application-db",namespace="my-application",reason="Deleting",version="v1alpha1"} 0
crossplane_status_ready_reason{group="database.crossplane.example.org",kind="MySQLInstance",name="my-application-db",namespace="my-application",reason="Unavailable",version="v1alpha1"} 0
# HELP crossplane_status_synced_reason Conditions for Synced - Reason
# TYPE crossplane_status_synced_reason gauge
crossplane_status_synced_reason{group="database.crossplane.example.org",kind="MySQLInstance",name="my-application-db",namespace="my-application",reason="ReconcileError",version="v1alpha1"} 0
crossplane_status_synced_reason{group="database.crossplane.example.org",kind="MySQLInstance",name="my-application-db",namespace="my-application",reason="ReconcilePaused",version="v1alpha1"} 0
crossplane_status_synced_reason{group="database.crossplane.example.org",kind="MySQLInstance",name="my-application-db",namespace="my-application",reason="ReconcileSuccess",version="v1alpha1"} 1
# HELP crossplane_status_ready Conditions for Ready - Status
# TYPE crossplane_status_ready gauge
crossplane_status_ready{group="database.crossplane.example.org",kind="MySQLInstance",name="my-application-db",namespace="my-application",status="False",version="v1alpha1"} 0
crossplane_status_ready{group="database.crossplane.example.org",kind="MySQLInstance",name="my-application-db",namespace="my-application",status="True",version="v1alpha1"} 1
# HELP crossplane_status_synced Conditions for Synced - Status
# TYPE crossplane_status_synced gauge
crossplane_status_synced{group="database.crossplane.example.org",kind="MySQLInstance",name="my-application-db",namespace="my-application",status="False",version="v1alpha1"} 0
crossplane_status_synced{group="database.crossplane.example.org",kind="MySQLInstance",name="my-application-db",namespace="my-application",status="True",version="v1alpha1"} 1

```


### fn statusResourceAlerts

```ts
statusResourceAlerts()
```

`statusResourceAlerts` provides a set of alerts for the metrics provided by `statusResource`

The output of this function can be used as a prometheus monitoring mixin.


### obj alerts


#### fn alerts.claimNotReadyAlert

```ts
claimNotReadyAlert(reason='.*', pendingFor='15m')
```

`claimNotReadyAlert` provides an alert for metrics provided by `statusResource`

`reason` can be set to differentiate between reasons as Create/Delete operations
may take a while.


Accepted values for `reason` are Unavailable, Creating, Deleting

#### fn alerts.claimNotSyncedAlert

```ts
claimNotSyncedAlert(pendingFor='15m')
```

`claimNotSyncedAlert` provides an alert for metrics provided by `statusResource`
