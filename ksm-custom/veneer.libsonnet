local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

{
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
}
