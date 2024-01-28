local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

(import './generated.libsonnet')
+ {
  '#'::
    d.pkg(
      name='ksm-custom',
      url='github.com/crdsonnet/ksm-custom-libsonnet/ksm-custom',
      help=|||
        `ksm-custom` can generate config for [Custom Resource State Metrics](https://github.com/kubernetes/kube-state-metrics/blob/main/docs/customresourcestate-metrics.md) from kube-state-metrics.
      |||,
      filename=std.thisFile,
    ),

  '#new':: d.fn('Initialize new CustomResourceStateMetrics object'),
  new(): {
    kind: 'CustomResourceStateMetrics',
  },

  spec+: {
    resources+: {
      '#withGroupVersionKind'::
        d.fn(
          'Set group, version and kind of the resource to scrape.',
          args=[
            d.arg('group', d.T.string),
            d.arg('version', d.T.string),
            d.arg('kind', d.T.string),
          ],
        ),
      withGroupVersionKind(group, version, kind):
        self.groupVersionKind.withGroup(group)
        + self.groupVersionKind.withVersion(version)
        + self.groupVersionKind.withKind(kind),
    },
  },

  crossplane: (import './crossplane.libsonnet'),
}
