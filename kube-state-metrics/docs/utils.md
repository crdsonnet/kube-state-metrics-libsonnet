# utils

Helper functions to use in combination with kube-state-metrics

## Index

* [`fn createWatchRules(groupResources)`](#fn-createwatchrules)
* [`fn scrapeConfig(namespace, name="kube-state-metrics")`](#fn-scrapeconfig)
* [`fn sortRules(rules)`](#fn-sortrules)

## Fields

### fn createWatchRules

```jsonnet
createWatchRules(groupResources)
```

PARAMETERS:

* **groupResources** (`array`)

`createWatchRules` turns an array of group/resources into a set of policyRules with
list/watch verbs.

For example, this array:

```jsonnet
[
  {
    group: 'apps',
    resources: ['daemonsets', 'deployments'],
  }
]
```

Will result in these policyRules:

```json
[
    {
      "apiGroups": [
        "apps"
      ],
      "resources": [
        "daemonsets",
        "deployments"
      ],
      "verbs": [
        "list",
        "watch"
      ]
    }
]
```

Additionally the policy rules array will be sorted so that the order of the
input array does not affect the output order.

### fn scrapeConfig

```jsonnet
scrapeConfig(namespace, name="kube-state-metrics")
```

PARAMETERS:

* **namespace** (`string`)
* **name** (`string`)
   - default value: `"kube-state-metrics"`

`scrapeConfig` provides a scrape config for kube-state-metrics for Prometheus.

This relates to the scrape configs in https://github.com/grafana/jsonnet-libs/tree/master/prometheus

This scrape config doesn't add namespace, container, and pod labels, instead taking
those labels from the exported timeseries. This prevents them being renamed to
exported_namespace etc. and allows us to route alerts based on namespace and join
KSM metrics with cAdvisor metrics.

### fn sortRules

```jsonnet
sortRules(rules)
```

PARAMETERS:

* **rules** (`array`)

`sortRules` sorts policy rules for consistent output.
