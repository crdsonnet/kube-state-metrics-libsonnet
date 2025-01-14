# stateMetrics

Provide metrics and alerts to gather stateMetrics for Crossplane resources.

## Index

* [`fn new(gvks)`](#fn-new)
* [`fn withNamespaceFromClaimLabels()`](#fn-withnamespacefromclaimlabels)
* [`obj alerts`](#obj-alerts)
  * [`fn predefined()`](#fn-alertspredefined)
  * [`obj claim`](#obj-alertsclaim)
    * [`fn claimNotReadyAlert(reasonFilter="reason=~\".*\"", pendingFor="15m", severity="warning")`](#fn-alertsclaimclaimnotreadyalert)
    * [`fn claimNotSyncedAlert(pendingFor="15m", severity="warning")`](#fn-alertsclaimclaimnotsyncedalert)

## Fields

### fn new

```jsonnet
new(gvks)
```

PARAMETERS:

* **gvks** (`array`)

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

### fn withNamespaceFromClaimLabels

```jsonnet
withNamespaceFromClaimLabels()
```


`withNamespaceFromClaimLabels` gets the claimName label and a namespace label from the crossplane.io/claim-{name,namespace} labels. This is particularly useful when monitoring Managed Resources that were created by a Composition.

### obj alerts


#### fn alerts.predefined

```jsonnet
alerts.predefined()
```


`predefined` provides a set of alerts for crossplane.stateMetrics.

The output of this function can be used as a prometheus monitoring mixin.

#### obj alerts.claim


##### fn alerts.claim.claimNotReadyAlert

```jsonnet
alerts.claim.claimNotReadyAlert(reasonFilter="reason=~\".*\"", pendingFor="15m", severity="warning")
```

PARAMETERS:

* **reasonFilter** (`string`)
   - default value: `"reason=~\".*\""`
* **pendingFor** (`string`)
   - default value: `"15m"`
* **severity** (`string`)
   - default value: `"warning"`

`claimNotReadyAlert` provides an alert for crossplane.stateMetrics, it'll fire when the resource is unable to become Ready.

It might be useful to create separate alerts for different `reason`, for example Create/Delete operations may take a while and should only alert when they are stuck.

##### fn alerts.claim.claimNotSyncedAlert

```jsonnet
alerts.claim.claimNotSyncedAlert(pendingFor="15m", severity="warning")
```

PARAMETERS:

* **pendingFor** (`string`)
   - default value: `"15m"`
* **severity** (`string`)
   - default value: `"warning"`

`claimNotSyncedAlert` provides an alert for crossplane.stateMetrics, it'll fire when the resource is unable to be Synced.