local crdsonnet = import 'github.com/crdsonnet/crdsonnet/crdsonnet/main.libsonnet';
local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

local render = 'dynamic';

local schema = import './schema.json';

local parsed = crdsonnet.fromSchema(
  'customResourceStateMetrics',
  schema,
  render=render
);

(
  if render == 'dynamic'
  then parsed.customResourceStateMetrics
  else parsed + '.customResourceStateMetrics'
)
+ (
  if render == 'dynamic'
  then import 'veneer.libsonnet'
  else importstr 'veneer.libsonnet'
)
+ (
  if render == 'dynamic'
  then
    {
      '#'::
        d.pkg(
          name='ksm-custom',
          url='github.com/crdsonnet/ksm-custom-libsonnet/ksm-custom',
          help=|||
            `ksm-custom` can generate config for [Custom Resource State Metrics](https://github.com/kubernetes/kube-state-metrics/blob/main/docs/customresourcestate-metrics.md) from kube-state-metrics.
          |||,
          filename=std.thisFile,
        ),
    }
  else ''  // don't bother with docs for static rendering
)
