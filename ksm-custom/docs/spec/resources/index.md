# resources



## Subpackages

* [metrics](metrics.md)

## Index

* [`fn new(prefix, group, version, kind)`](#fn-new)
* [`fn withCommonLabels(value)`](#fn-withcommonlabels)
* [`fn withCommonLabelsMixin(value)`](#fn-withcommonlabelsmixin)
* [`fn withErrorLogV(value)`](#fn-witherrorlogv)
* [`fn withGroupVersionKind(group, version, kind)`](#fn-withgroupversionkind)
* [`fn withGroupVersionKindMixin(value)`](#fn-withgroupversionkindmixin)
* [`fn withLabelsFromPath(value)`](#fn-withlabelsfrompath)
* [`fn withLabelsFromPathMixin(value)`](#fn-withlabelsfrompathmixin)
* [`fn withMetricNamePrefix(value)`](#fn-withmetricnameprefix)
* [`fn withMetrics(value)`](#fn-withmetrics)
* [`fn withMetricsMixin(value)`](#fn-withmetricsmixin)
* [`fn withNamespaceFromResource()`](#fn-withnamespacefromresource)
* [`fn withResourcePlural(value)`](#fn-withresourceplural)
* [`obj groupVersionKind`](#obj-groupversionkind)
  * [`fn withGroup(value)`](#fn-groupversionkindwithgroup)
  * [`fn withKind(value)`](#fn-groupversionkindwithkind)
  * [`fn withPlural(plural)`](#fn-groupversionkindwithplural)
  * [`fn withVersion(value)`](#fn-groupversionkindwithversion)

## Fields

### fn new

```jsonnet
new(prefix, group, version, kind)
```

PARAMETERS:

* **prefix** (`string`)
* **group** (`string`)
* **version** (`string`)
* **kind** (`string`)

`new` creates a new resource with a metric name prefix and the group, version and kind of the resource to scrape, the scraped metrics will include labels for the name and namespace.
### fn withCommonLabels

```jsonnet
withCommonLabels(value)
```

PARAMETERS:

* **value** (`object`)


### fn withCommonLabelsMixin

```jsonnet
withCommonLabelsMixin(value)
```

PARAMETERS:

* **value** (`object`)


### fn withErrorLogV

```jsonnet
withErrorLogV(value)
```

PARAMETERS:

* **value** (`integer`)


### fn withGroupVersionKind

```jsonnet
withGroupVersionKind(group, version, kind)
```

PARAMETERS:

* **group** (`string`)
* **version** (`string`)
* **kind** (`string`)

`withGroupVersionKind` sets the group, version and kind of the resource to scrape.
### fn withGroupVersionKindMixin

```jsonnet
withGroupVersionKindMixin(value)
```

PARAMETERS:

* **value** (`object`)


### fn withLabelsFromPath

```jsonnet
withLabelsFromPath(value)
```

PARAMETERS:

* **value** (`object`)


### fn withLabelsFromPathMixin

```jsonnet
withLabelsFromPathMixin(value)
```

PARAMETERS:

* **value** (`object`)


### fn withMetricNamePrefix

```jsonnet
withMetricNamePrefix(value)
```

PARAMETERS:

* **value** (`string`)


### fn withMetrics

```jsonnet
withMetrics(value)
```

PARAMETERS:

* **value** (`array`)


### fn withMetricsMixin

```jsonnet
withMetricsMixin(value)
```

PARAMETERS:

* **value** (`array`)


### fn withNamespaceFromResource

```jsonnet
withNamespaceFromResource()
```


`withNamespaceFromResource` gets the name and namespace labels from the resource metadata.
### fn withResourcePlural

```jsonnet
withResourcePlural(value)
```

PARAMETERS:

* **value** (`string`)


### obj groupVersionKind


#### fn groupVersionKind.withGroup

```jsonnet
groupVersionKind.withGroup(value)
```

PARAMETERS:

* **value** (`string`)


#### fn groupVersionKind.withKind

```jsonnet
groupVersionKind.withKind(value)
```

PARAMETERS:

* **value** (`string`)


#### fn groupVersionKind.withPlural

```jsonnet
groupVersionKind.withPlural(plural)
```

PARAMETERS:

* **plural** (`string`)

`withPlural` adds the plural of the GroupVersionKind to a hidden field. It is not used by CustomResourceStateMetrics but can be used to generate PolicyRule objects.

See `withCustomResourceStateMetrics()` on the kube-state-metrics library in this repository.

#### fn groupVersionKind.withVersion

```jsonnet
groupVersionKind.withVersion(value)
```

PARAMETERS:

* **value** (`string`)

