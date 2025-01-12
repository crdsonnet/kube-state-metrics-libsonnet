# ksm-custom

`ksm-custom` can generate config for [Custom Resource State Metrics](https://github.com/kubernetes/kube-state-metrics/blob/main/docs/customresourcestate-metrics.md) from kube-state-metrics.

## Install

```
jb install github.com/crdsonnet/ksm-custom-libsonnet/ksm-custom@master
```

## Usage

```jsonnet
local ksm-custom = import "github.com/crdsonnet/ksm-custom-libsonnet/ksm-custom/main.libsonnet"
```


## Subpackages

* [alerts](alerts.md)
* [crossplane](crossplane/index.md)
* [spec.resources](spec/resources/index.md)

## Index

* [`fn new()`](#fn-new)
* [`fn withSpec(value)`](#fn-withspec)
* [`fn withSpecMixin(value)`](#fn-withspecmixin)
* [`obj spec`](#obj-spec)
  * [`fn withResources(value)`](#fn-specwithresources)
  * [`fn withResourcesMixin(value)`](#fn-specwithresourcesmixin)

## Fields

### fn new

```jsonnet
new()
```


Initialize new CustomResourceStateMetrics object
### fn withSpec

```jsonnet
withSpec(value)
```

PARAMETERS:

* **value** (`object`)


### fn withSpecMixin

```jsonnet
withSpecMixin(value)
```

PARAMETERS:

* **value** (`object`)


### obj spec


#### fn spec.withResources

```jsonnet
spec.withResources(value)
```

PARAMETERS:

* **value** (`array`)


#### fn spec.withResourcesMixin

```jsonnet
spec.withResourcesMixin(value)
```

PARAMETERS:

* **value** (`array`)

