local ksmCustom = import 'ksm-custom/main.libsonnet';
local crsm = ksmCustom.customResourceStateMetrics;  // shortcut


//kind: CustomResourceStateMetrics
//spec:
//  resources:
//    - groupVersionKind:
//        group: database.gcp.crossplane.io
//        kind: "CloudSQLInstance"
//        version: "v1beta1"
//      labelsFromPath:
//        name: [metadata, name]
//        namespace: [metadata, namespace]
//      metricNamePrefix: 'xplane_cloudsqlinstance'
//      metrics:
//        - name: "databaseVersion"
//          help: "Database version"
//          each:
//            type: Info
//            info:
//              labelsFromPath:
//                version: [spec, forProvider, databaseVersion]
crsm.new()
+ crsm.spec.withResources([
  local resource = crsm.spec.resources;
  resource.withGroupVersionKind(
    'database.gcp.crossplane.io',
    'v1beta1',
    'CloudSQLInstance',
  )
  + resource.withMetricNamePrefix('xplane_cloudsqlinstance')
  + resource.withLabelsFromPath({
    name: ['metadata', 'name'],
  })
  + resource.withMetrics([
    local metric = crsm.spec.resources.metrics;
    metric.withName('databaseVersion')
    + metric.withHelp('Database Version')
    + metric.each.withType('Info')
    + metric.each.info.withLabelsFromPath({
      version:
        ['spec', 'forProvider', 'databaseVersion'],
    }),
  ]),
])
