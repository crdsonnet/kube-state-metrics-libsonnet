{
  '#withAnnotationsAllowList': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: 'LabelsAllowList represents a list of allowed labels for metrics.' } },
  withAnnotationsAllowList(value): {
    annotations_allow_list: value,
  },
  '#withAnnotationsAllowListMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: 'LabelsAllowList represents a list of allowed labels for metrics.' } },
  withAnnotationsAllowListMixin(value): {
    annotations_allow_list+: value,
  },
  '#withApiserver': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['string'] }], help: '' } },
  withApiserver(value): {
    apiserver: value,
  },
  '#withCustomResourceConfig': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['string'] }], help: '' } },
  withCustomResourceConfig(value): {
    custom_resource_config: value,
  },
  '#withCustomResourceConfigFile': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['string'] }], help: '' } },
  withCustomResourceConfigFile(value): {
    custom_resource_config_file: value,
  },
  '#withCustomResourcesOnly': { 'function': { args: [{ default: true, enums: null, name: 'value', type: ['boolean'] }], help: '' } },
  withCustomResourcesOnly(value=true): {
    custom_resources_only: value,
  },
  '#withEnableGzipEncoding': { 'function': { args: [{ default: true, enums: null, name: 'value', type: ['boolean'] }], help: '' } },
  withEnableGzipEncoding(value=true): {
    enable_gzip_encoding: value,
  },
  '#withHost': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['string'] }], help: '' } },
  withHost(value): {
    host: value,
  },
  '#withKubeconfig': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['string'] }], help: '' } },
  withKubeconfig(value): {
    kubeconfig: value,
  },
  '#withLabelsAllowList': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: 'LabelsAllowList represents a list of allowed labels for metrics.' } },
  withLabelsAllowList(value): {
    labels_allow_list: value,
  },
  '#withLabelsAllowListMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: 'LabelsAllowList represents a list of allowed labels for metrics.' } },
  withLabelsAllowListMixin(value): {
    labels_allow_list+: value,
  },
  '#withMetricAllowlist': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: 'MetricSet represents a collection which has a unique set of metrics.' } },
  withMetricAllowlist(value): {
    metric_allowlist: value,
  },
  '#withMetricAllowlistMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: 'MetricSet represents a collection which has a unique set of metrics.' } },
  withMetricAllowlistMixin(value): {
    metric_allowlist+: value,
  },
  '#withMetricDenylist': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: 'MetricSet represents a collection which has a unique set of metrics.' } },
  withMetricDenylist(value): {
    metric_denylist: value,
  },
  '#withMetricDenylistMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: 'MetricSet represents a collection which has a unique set of metrics.' } },
  withMetricDenylistMixin(value): {
    metric_denylist+: value,
  },
  '#withMetricOptInList': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: 'MetricSet represents a collection which has a unique set of metrics.' } },
  withMetricOptInList(value): {
    metric_opt_in_list: value,
  },
  '#withMetricOptInListMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: 'MetricSet represents a collection which has a unique set of metrics.' } },
  withMetricOptInListMixin(value): {
    metric_opt_in_list+: value,
  },
  '#withNamespace': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['string'] }], help: '' } },
  withNamespace(value): {
    namespace: value,
  },
  '#withNamespaces': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['array'] }], help: 'NamespaceList represents a list of namespaces to query from.' } },
  withNamespaces(value): {
    namespaces:
      (if std.isArray(value)
       then value
       else [value]),
  },
  '#withNamespacesMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['array'] }], help: 'NamespaceList represents a list of namespaces to query from.' } },
  withNamespacesMixin(value): {
    namespaces+:
      (if std.isArray(value)
       then value
       else [value]),
  },
  '#withNamespacesDenylist': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['array'] }], help: 'NamespaceList represents a list of namespaces to query from.' } },
  withNamespacesDenylist(value): {
    namespaces_denylist:
      (if std.isArray(value)
       then value
       else [value]),
  },
  '#withNamespacesDenylistMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['array'] }], help: 'NamespaceList represents a list of namespaces to query from.' } },
  withNamespacesDenylistMixin(value): {
    namespaces_denylist+:
      (if std.isArray(value)
       then value
       else [value]),
  },
  '#withNode': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['string'] }], help: '' } },
  withNode(value): {
    node: value,
  },
  '#withPod': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['string'] }], help: '' } },
  withPod(value): {
    pod: value,
  },
  '#withPort': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['integer'] }], help: '' } },
  withPort(value): {
    port: value,
  },
  '#withResources': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: 'ResourceSet represents a collection which has a unique set of resources.' } },
  withResources(value): {
    resources: value,
  },
  '#withResourcesMixin': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['object'] }], help: 'ResourceSet represents a collection which has a unique set of resources.' } },
  withResourcesMixin(value): {
    resources+: value,
  },
  '#withShard': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['integer'] }], help: '' } },
  withShard(value): {
    shard: value,
  },
  '#withTelemetryHost': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['string'] }], help: '' } },
  withTelemetryHost(value): {
    telemetry_host: value,
  },
  '#withTelemetryPort': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['integer'] }], help: '' } },
  withTelemetryPort(value): {
    telemetry_port: value,
  },
  '#withTlsConfig': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['string'] }], help: '' } },
  withTlsConfig(value): {
    tls_config: value,
  },
  '#withTotalShards': { 'function': { args: [{ default: null, enums: null, name: 'value', type: ['integer'] }], help: '' } },
  withTotalShards(value): {
    total_shards: value,
  },
  '#withUseApiServerCache': { 'function': { args: [{ default: true, enums: null, name: 'value', type: ['boolean'] }], help: '' } },
  withUseApiServerCache(value=true): {
    use_api_server_cache: value,
  },
}
