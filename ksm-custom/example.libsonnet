local ksmCustom = import './main.libsonnet';

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

ksmCustom.new()
+ ksmCustom.spec.withResources([
  local resource = ksmCustom.spec.resources;
  resource.withGroupVersionKind(
    'myteam.io',
    'foo',
    'v1',
  )
  + resource.withMetrics([
    local metric = ksmCustom.spec.resources.metrics;
    metric.withName('uptime')
    + metric.withHelp('Foo uptime')
    + metric.each.withType('Gauge')
    + metric.each.gauge.withPath(['status', 'uptime']),
  ]),
])
