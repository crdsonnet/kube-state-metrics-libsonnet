local ksmCustom = import './main.libsonnet';
local crsm = ksmCustom.customResourceStateMetrics;  // shortcut

// Example: rebuild example from docs with Jsonnet to validate the library

//kind: CustomResourceStateMetrics
//spec:
//  resources:
//    - groupVersionKind:
//        group: myteam.io
//        kind: "Foo"
//        version: "v1"
//      metrics:
//        - name: "uptime"
//          help: "Foo uptime"
//          each:
//            type: Gauge
//            gauge:
//              path: [status, uptime]

crsm.new()
+ crsm.spec.withResources([
  local resource = crsm.spec.resources;
  resource.withGroupVersionKind(
    'myteam.io',
    'foo',
    'v1',
  )
  + resource.withMetrics([
    local metric = crsm.spec.resources.metrics;
    metric.withName('uptime')
    + metric.withHelp('Foo uptime')
    + metric.each.withType('Gauge')
    + metric.each.gauge.withPath(['status', 'uptime']),
  ]),
])
