local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

(import './generated.libsonnet')
+ {
  local root = self,

  '#'::
    d.pkg(
      name='ksm-config',
      url='github.com/crdsonnet/ksm-custom-libsonnet/ksm-config',
      help=|||
        `ksm-config` can generate config for kube-state-metrics.
      |||,
      filename=std.thisFile,
    ),

  // These parameters are represented as map[string]interface however they only take an array of strings on the CLI. This adds a convenience function that if an array is passed, it'll get transformed to an object.
  local arrayToObject(value) =
    if std.isArray(value)
    then {
      [item]: {}
      for item in value
    }
    else value,
  local arrayToObjectDocMixin() = {
    'function'+: {
      args: [{ name: 'value', type: ['array', 'object'] }],
    },
  },
  '#withMetricAllowlist'+: arrayToObjectDocMixin(),
  withMetricAllowlist(value): {
    metric_allowlist: arrayToObject(value),
  },
  '#withMetricAllowlistMixin'+: arrayToObjectDocMixin(),
  withMetricAllowlistMixin(value): {
    metric_allowlist+: arrayToObject(value),
  },
  '#withMetricDenylist'+: arrayToObjectDocMixin(),
  withMetricDenylist(value): {
    metric_denylist: arrayToObject(value),
  },
  '#withMetricDenylistMixin'+: arrayToObjectDocMixin(),
  withMetricDenylistMixin(value): {
    metric_denylist+: arrayToObject(value),
  },
  '#withMetricOptInList'+: arrayToObjectDocMixin(),
  withMetricOptInList(value): {
    metric_opt_in_list: arrayToObject(value),
  },
  '#withMetricOptInListMixin'+: arrayToObjectDocMixin(),
  withMetricOptInListMixin(value): {
    metric_opt_in_list+: arrayToObject(value),
  },
  '#withResources'+: arrayToObjectDocMixin(),
  withResources(value): {
    resources: arrayToObject(value),
  },
  '#withResourcesMixin'+: arrayToObjectDocMixin(),
  withResourcesMixin(value): {
    resources+: arrayToObject(value),
  },

  local allowListDocMixin() = {
    'function'+: {
      help+:
        |||
          `value` looks like this:

          ```jsonnet
          {
              // Structure:
              //'<plural_resourcename>': [
              //  '<key1>',
              //  '<key2>',
              //],

              // Example:
              nodes: [
                'cloud.google.com/gke-nodepool',
                'eks.amazonaws.com/nodegroup',
              ],
          }
          ```
        |||,
    },
  },
  '#withAnnotationsAllowList'+: allowListDocMixin(),
  '#withAnnotationsAllowListMixin'+: allowListDocMixin(),
  '#withLabelsAllowList'+: allowListDocMixin(),
  '#withLabelsAllowListMixin'+: allowListDocMixin(),


}
