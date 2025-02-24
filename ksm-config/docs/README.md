# ksm-config

`ksm-config` can generate config for kube-state-metrics.

## Install

```
jb install github.com/crdsonnet/ksm-custom-libsonnet/ksm-config@master
```

## Usage

```jsonnet
local ksm-config = import "github.com/crdsonnet/ksm-custom-libsonnet/ksm-config/main.libsonnet"
```


## Index

* [`fn withAnnotationsAllowList(value)`](#fn-withannotationsallowlist)
* [`fn withAnnotationsAllowListMixin(value)`](#fn-withannotationsallowlistmixin)
* [`fn withApiserver(value)`](#fn-withapiserver)
* [`fn withCustomResourceConfigFile(value)`](#fn-withcustomresourceconfigfile)
* [`fn withCustomResourcesOnly(value=true)`](#fn-withcustomresourcesonly)
* [`fn withEnableGzipEncoding(value=true)`](#fn-withenablegzipencoding)
* [`fn withHost(value)`](#fn-withhost)
* [`fn withKubeconfig(value)`](#fn-withkubeconfig)
* [`fn withLabelsAllowList(value)`](#fn-withlabelsallowlist)
* [`fn withLabelsAllowListMixin(value)`](#fn-withlabelsallowlistmixin)
* [`fn withMetricAllowlist(value)`](#fn-withmetricallowlist)
* [`fn withMetricAllowlistMixin(value)`](#fn-withmetricallowlistmixin)
* [`fn withMetricDenylist(value)`](#fn-withmetricdenylist)
* [`fn withMetricDenylistMixin(value)`](#fn-withmetricdenylistmixin)
* [`fn withMetricOptInList(value)`](#fn-withmetricoptinlist)
* [`fn withMetricOptInListMixin(value)`](#fn-withmetricoptinlistmixin)
* [`fn withNamespace(value)`](#fn-withnamespace)
* [`fn withNamespaces(value)`](#fn-withnamespaces)
* [`fn withNamespacesDenylist(value)`](#fn-withnamespacesdenylist)
* [`fn withNamespacesDenylistMixin(value)`](#fn-withnamespacesdenylistmixin)
* [`fn withNamespacesMixin(value)`](#fn-withnamespacesmixin)
* [`fn withNode(value)`](#fn-withnode)
* [`fn withPod(value)`](#fn-withpod)
* [`fn withPort(value)`](#fn-withport)
* [`fn withResources(value)`](#fn-withresources)
* [`fn withResourcesMixin(value)`](#fn-withresourcesmixin)
* [`fn withShard(value)`](#fn-withshard)
* [`fn withTelemetryHost(value)`](#fn-withtelemetryhost)
* [`fn withTelemetryPort(value)`](#fn-withtelemetryport)
* [`fn withTlsConfig(value)`](#fn-withtlsconfig)
* [`fn withTotalShards(value)`](#fn-withtotalshards)
* [`fn withUseApiServerCache(value=true)`](#fn-withuseapiservercache)

## Fields

### fn withAnnotationsAllowList

```jsonnet
withAnnotationsAllowList(value)
```

PARAMETERS:

* **value** (`object`)

LabelsAllowList represents a list of allowed labels for metrics.`value` looks like this:

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

### fn withAnnotationsAllowListMixin

```jsonnet
withAnnotationsAllowListMixin(value)
```

PARAMETERS:

* **value** (`object`)

LabelsAllowList represents a list of allowed labels for metrics.`value` looks like this:

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

### fn withApiserver

```jsonnet
withApiserver(value)
```

PARAMETERS:

* **value** (`string`)


### fn withCustomResourceConfigFile

```jsonnet
withCustomResourceConfigFile(value)
```

PARAMETERS:

* **value** (`string`)


### fn withCustomResourcesOnly

```jsonnet
withCustomResourcesOnly(value=true)
```

PARAMETERS:

* **value** (`boolean`)
   - default value: `true`


### fn withEnableGzipEncoding

```jsonnet
withEnableGzipEncoding(value=true)
```

PARAMETERS:

* **value** (`boolean`)
   - default value: `true`


### fn withHost

```jsonnet
withHost(value)
```

PARAMETERS:

* **value** (`string`)


### fn withKubeconfig

```jsonnet
withKubeconfig(value)
```

PARAMETERS:

* **value** (`string`)


### fn withLabelsAllowList

```jsonnet
withLabelsAllowList(value)
```

PARAMETERS:

* **value** (`object`)

LabelsAllowList represents a list of allowed labels for metrics.`value` looks like this:

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

### fn withLabelsAllowListMixin

```jsonnet
withLabelsAllowListMixin(value)
```

PARAMETERS:

* **value** (`object`)

LabelsAllowList represents a list of allowed labels for metrics.`value` looks like this:

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

### fn withMetricAllowlist

```jsonnet
withMetricAllowlist(value)
```

PARAMETERS:

* **value** (`array`,`object`)

MetricSet represents a collection which has a unique set of metrics.
### fn withMetricAllowlistMixin

```jsonnet
withMetricAllowlistMixin(value)
```

PARAMETERS:

* **value** (`array`,`object`)

MetricSet represents a collection which has a unique set of metrics.
### fn withMetricDenylist

```jsonnet
withMetricDenylist(value)
```

PARAMETERS:

* **value** (`array`,`object`)

MetricSet represents a collection which has a unique set of metrics.
### fn withMetricDenylistMixin

```jsonnet
withMetricDenylistMixin(value)
```

PARAMETERS:

* **value** (`array`,`object`)

MetricSet represents a collection which has a unique set of metrics.
### fn withMetricOptInList

```jsonnet
withMetricOptInList(value)
```

PARAMETERS:

* **value** (`array`,`object`)

MetricSet represents a collection which has a unique set of metrics.
### fn withMetricOptInListMixin

```jsonnet
withMetricOptInListMixin(value)
```

PARAMETERS:

* **value** (`array`,`object`)

MetricSet represents a collection which has a unique set of metrics.
### fn withNamespace

```jsonnet
withNamespace(value)
```

PARAMETERS:

* **value** (`string`)


### fn withNamespaces

```jsonnet
withNamespaces(value)
```

PARAMETERS:

* **value** (`array`)

NamespaceList represents a list of namespaces to query from.
### fn withNamespacesDenylist

```jsonnet
withNamespacesDenylist(value)
```

PARAMETERS:

* **value** (`array`)

NamespaceList represents a list of namespaces to query from.
### fn withNamespacesDenylistMixin

```jsonnet
withNamespacesDenylistMixin(value)
```

PARAMETERS:

* **value** (`array`)

NamespaceList represents a list of namespaces to query from.
### fn withNamespacesMixin

```jsonnet
withNamespacesMixin(value)
```

PARAMETERS:

* **value** (`array`)

NamespaceList represents a list of namespaces to query from.
### fn withNode

```jsonnet
withNode(value)
```

PARAMETERS:

* **value** (`string`)


### fn withPod

```jsonnet
withPod(value)
```

PARAMETERS:

* **value** (`string`)


### fn withPort

```jsonnet
withPort(value)
```

PARAMETERS:

* **value** (`integer`)


### fn withResources

```jsonnet
withResources(value)
```

PARAMETERS:

* **value** (`array`,`object`)

ResourceSet represents a collection which has a unique set of resources.
### fn withResourcesMixin

```jsonnet
withResourcesMixin(value)
```

PARAMETERS:

* **value** (`array`,`object`)

ResourceSet represents a collection which has a unique set of resources.
### fn withShard

```jsonnet
withShard(value)
```

PARAMETERS:

* **value** (`integer`)


### fn withTelemetryHost

```jsonnet
withTelemetryHost(value)
```

PARAMETERS:

* **value** (`string`)


### fn withTelemetryPort

```jsonnet
withTelemetryPort(value)
```

PARAMETERS:

* **value** (`integer`)


### fn withTlsConfig

```jsonnet
withTlsConfig(value)
```

PARAMETERS:

* **value** (`string`)


### fn withTotalShards

```jsonnet
withTotalShards(value)
```

PARAMETERS:

* **value** (`integer`)


### fn withUseApiServerCache

```jsonnet
withUseApiServerCache(value=true)
```

PARAMETERS:

* **value** (`boolean`)
   - default value: `true`

