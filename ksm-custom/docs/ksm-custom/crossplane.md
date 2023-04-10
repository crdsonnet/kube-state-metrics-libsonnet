# crossplane

Helper functions related to Crossplane

## Index

* [`fn statusResource(group, version, kind)`](#fn-statusresource)

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

