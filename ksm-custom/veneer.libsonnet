{
  customResourceMetricsState: {
    new(): {
      kind: 'CustomResourceStateMetrics',
    },
    spec+: {
      resources+: {
        withGroupVersionKind(group, version, kind):
          self.groupVersionKind.withGroup(group)
          + self.groupVersionKind.withVersion(version)
          + self.groupVersionKind.withKind(kind),
      },
    },
  },
}
