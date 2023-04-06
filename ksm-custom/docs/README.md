# package ksm-custom

`ksm-custom` can generate config for [Custom Resource State Metrics](https://github.com/kubernetes/kube-state-metrics/blob/main/docs/customresourcestate-metrics.md) from kube-state-metrics.


## Install

```
jb install github.com/crdsonnet/ksm-custom-libsonnet/ksm-custom@master
```

## Usage

```jsonnet
local ksm-custom = import "github.com/crdsonnet/ksm-custom-libsonnet/ksm-custom/main.libsonnet"
```

## Index

* [`fn new()`](#fn-new)
* [`fn withSpec(value)`](#fn-withspec)
* [`fn withSpecMixin(value)`](#fn-withspecmixin)
* [`obj spec`](#obj-spec)
  * [`fn withResources(value)`](#fn-specwithresources)
  * [`fn withResourcesMixin(value)`](#fn-specwithresourcesmixin)
  * [`obj resources`](#obj-specresources)
    * [`fn withCommonLabels(value)`](#fn-specresourceswithcommonlabels)
    * [`fn withCommonLabelsMixin(value)`](#fn-specresourceswithcommonlabelsmixin)
    * [`fn withErrorLogV(value)`](#fn-specresourceswitherrorlogv)
    * [`fn withGroupVersionKind(group, version, kind)`](#fn-specresourceswithgroupversionkind)
    * [`fn withGroupVersionKindMixin(value)`](#fn-specresourceswithgroupversionkindmixin)
    * [`fn withLabelsFromPath(value)`](#fn-specresourceswithlabelsfrompath)
    * [`fn withLabelsFromPathMixin(value)`](#fn-specresourceswithlabelsfrompathmixin)
    * [`fn withMetricNamePrefix(value)`](#fn-specresourceswithmetricnameprefix)
    * [`fn withMetrics(value)`](#fn-specresourceswithmetrics)
    * [`fn withMetricsMixin(value)`](#fn-specresourceswithmetricsmixin)
    * [`fn withResourcePlural(value)`](#fn-specresourceswithresourceplural)
    * [`obj groupVersionKind`](#obj-specresourcesgroupversionkind)
      * [`fn withGroup(value)`](#fn-specresourcesgroupversionkindwithgroup)
      * [`fn withKind(value)`](#fn-specresourcesgroupversionkindwithkind)
      * [`fn withVersion(value)`](#fn-specresourcesgroupversionkindwithversion)
    * [`obj metrics`](#obj-specresourcesmetrics)
      * [`fn withCommonLabels(value)`](#fn-specresourcesmetricswithcommonlabels)
      * [`fn withCommonLabelsMixin(value)`](#fn-specresourcesmetricswithcommonlabelsmixin)
      * [`fn withEach(value)`](#fn-specresourcesmetricswitheach)
      * [`fn withEachMixin(value)`](#fn-specresourcesmetricswitheachmixin)
      * [`fn withErrorLogV(value)`](#fn-specresourcesmetricswitherrorlogv)
      * [`fn withHelp(value)`](#fn-specresourcesmetricswithhelp)
      * [`fn withLabelsFromPath(value)`](#fn-specresourcesmetricswithlabelsfrompath)
      * [`fn withLabelsFromPathMixin(value)`](#fn-specresourcesmetricswithlabelsfrompathmixin)
      * [`fn withName(value)`](#fn-specresourcesmetricswithname)
      * [`obj each`](#obj-specresourcesmetricseach)
        * [`fn withGauge(value)`](#fn-specresourcesmetricseachwithgauge)
        * [`fn withGaugeMixin(value)`](#fn-specresourcesmetricseachwithgaugemixin)
        * [`fn withInfo(value)`](#fn-specresourcesmetricseachwithinfo)
        * [`fn withInfoMixin(value)`](#fn-specresourcesmetricseachwithinfomixin)
        * [`fn withStateSet(value)`](#fn-specresourcesmetricseachwithstateset)
        * [`fn withStateSetMixin(value)`](#fn-specresourcesmetricseachwithstatesetmixin)
        * [`fn withType(value)`](#fn-specresourcesmetricseachwithtype)
        * [`obj gauge`](#obj-specresourcesmetricseachgauge)
          * [`fn withLabelFromKey(value)`](#fn-specresourcesmetricseachgaugewithlabelfromkey)
          * [`fn withLabelsFromPath(value)`](#fn-specresourcesmetricseachgaugewithlabelsfrompath)
          * [`fn withLabelsFromPathMixin(value)`](#fn-specresourcesmetricseachgaugewithlabelsfrompathmixin)
          * [`fn withNilIsZero(value)`](#fn-specresourcesmetricseachgaugewithniliszero)
          * [`fn withPath(value)`](#fn-specresourcesmetricseachgaugewithpath)
          * [`fn withPathMixin(value)`](#fn-specresourcesmetricseachgaugewithpathmixin)
          * [`fn withValueFrom(value)`](#fn-specresourcesmetricseachgaugewithvaluefrom)
          * [`fn withValueFromMixin(value)`](#fn-specresourcesmetricseachgaugewithvaluefrommixin)
        * [`obj info`](#obj-specresourcesmetricseachinfo)
          * [`fn withLabelFromKey(value)`](#fn-specresourcesmetricseachinfowithlabelfromkey)
          * [`fn withLabelsFromPath(value)`](#fn-specresourcesmetricseachinfowithlabelsfrompath)
          * [`fn withLabelsFromPathMixin(value)`](#fn-specresourcesmetricseachinfowithlabelsfrompathmixin)
          * [`fn withPath(value)`](#fn-specresourcesmetricseachinfowithpath)
          * [`fn withPathMixin(value)`](#fn-specresourcesmetricseachinfowithpathmixin)
        * [`obj stateSet`](#obj-specresourcesmetricseachstateset)
          * [`fn withLabelName(value)`](#fn-specresourcesmetricseachstatesetwithlabelname)
          * [`fn withLabelsFromPath(value)`](#fn-specresourcesmetricseachstatesetwithlabelsfrompath)
          * [`fn withLabelsFromPathMixin(value)`](#fn-specresourcesmetricseachstatesetwithlabelsfrompathmixin)
          * [`fn withList(value)`](#fn-specresourcesmetricseachstatesetwithlist)
          * [`fn withListMixin(value)`](#fn-specresourcesmetricseachstatesetwithlistmixin)
          * [`fn withPath(value)`](#fn-specresourcesmetricseachstatesetwithpath)
          * [`fn withPathMixin(value)`](#fn-specresourcesmetricseachstatesetwithpathmixin)
          * [`fn withValueFrom(value)`](#fn-specresourcesmetricseachstatesetwithvaluefrom)
          * [`fn withValueFromMixin(value)`](#fn-specresourcesmetricseachstatesetwithvaluefrommixin)

## Fields

### fn new

```ts
new()
```

Initialize new CustomResourceStateMetrics object

### fn withSpec

```ts
withSpec(value)
```



### fn withSpecMixin

```ts
withSpecMixin(value)
```



### obj spec


#### fn spec.withResources

```ts
withResources(value)
```



#### fn spec.withResourcesMixin

```ts
withResourcesMixin(value)
```



#### obj spec.resources


##### fn spec.resources.withCommonLabels

```ts
withCommonLabels(value)
```



##### fn spec.resources.withCommonLabelsMixin

```ts
withCommonLabelsMixin(value)
```



##### fn spec.resources.withErrorLogV

```ts
withErrorLogV(value)
```



##### fn spec.resources.withGroupVersionKind

```ts
withGroupVersionKind(group, version, kind)
```

Set group, version and kind of the resource to scrape.

##### fn spec.resources.withGroupVersionKindMixin

```ts
withGroupVersionKindMixin(value)
```



##### fn spec.resources.withLabelsFromPath

```ts
withLabelsFromPath(value)
```



##### fn spec.resources.withLabelsFromPathMixin

```ts
withLabelsFromPathMixin(value)
```



##### fn spec.resources.withMetricNamePrefix

```ts
withMetricNamePrefix(value)
```



##### fn spec.resources.withMetrics

```ts
withMetrics(value)
```



##### fn spec.resources.withMetricsMixin

```ts
withMetricsMixin(value)
```



##### fn spec.resources.withResourcePlural

```ts
withResourcePlural(value)
```



##### obj spec.resources.groupVersionKind


###### fn spec.resources.groupVersionKind.withGroup

```ts
withGroup(value)
```



###### fn spec.resources.groupVersionKind.withKind

```ts
withKind(value)
```



###### fn spec.resources.groupVersionKind.withVersion

```ts
withVersion(value)
```



##### obj spec.resources.metrics


###### fn spec.resources.metrics.withCommonLabels

```ts
withCommonLabels(value)
```



###### fn spec.resources.metrics.withCommonLabelsMixin

```ts
withCommonLabelsMixin(value)
```



###### fn spec.resources.metrics.withEach

```ts
withEach(value)
```



###### fn spec.resources.metrics.withEachMixin

```ts
withEachMixin(value)
```



###### fn spec.resources.metrics.withErrorLogV

```ts
withErrorLogV(value)
```



###### fn spec.resources.metrics.withHelp

```ts
withHelp(value)
```



###### fn spec.resources.metrics.withLabelsFromPath

```ts
withLabelsFromPath(value)
```



###### fn spec.resources.metrics.withLabelsFromPathMixin

```ts
withLabelsFromPathMixin(value)
```



###### fn spec.resources.metrics.withName

```ts
withName(value)
```



###### obj spec.resources.metrics.each


####### fn spec.resources.metrics.each.withGauge

```ts
withGauge(value)
```



####### fn spec.resources.metrics.each.withGaugeMixin

```ts
withGaugeMixin(value)
```



####### fn spec.resources.metrics.each.withInfo

```ts
withInfo(value)
```



####### fn spec.resources.metrics.each.withInfoMixin

```ts
withInfoMixin(value)
```



####### fn spec.resources.metrics.each.withStateSet

```ts
withStateSet(value)
```



####### fn spec.resources.metrics.each.withStateSetMixin

```ts
withStateSetMixin(value)
```



####### fn spec.resources.metrics.each.withType

```ts
withType(value)
```



####### obj spec.resources.metrics.each.gauge


######## fn spec.resources.metrics.each.gauge.withLabelFromKey

```ts
withLabelFromKey(value)
```



######## fn spec.resources.metrics.each.gauge.withLabelsFromPath

```ts
withLabelsFromPath(value)
```



######## fn spec.resources.metrics.each.gauge.withLabelsFromPathMixin

```ts
withLabelsFromPathMixin(value)
```



######## fn spec.resources.metrics.each.gauge.withNilIsZero

```ts
withNilIsZero(value)
```



######## fn spec.resources.metrics.each.gauge.withPath

```ts
withPath(value)
```



######## fn spec.resources.metrics.each.gauge.withPathMixin

```ts
withPathMixin(value)
```



######## fn spec.resources.metrics.each.gauge.withValueFrom

```ts
withValueFrom(value)
```



######## fn spec.resources.metrics.each.gauge.withValueFromMixin

```ts
withValueFromMixin(value)
```



####### obj spec.resources.metrics.each.info


######## fn spec.resources.metrics.each.info.withLabelFromKey

```ts
withLabelFromKey(value)
```



######## fn spec.resources.metrics.each.info.withLabelsFromPath

```ts
withLabelsFromPath(value)
```



######## fn spec.resources.metrics.each.info.withLabelsFromPathMixin

```ts
withLabelsFromPathMixin(value)
```



######## fn spec.resources.metrics.each.info.withPath

```ts
withPath(value)
```



######## fn spec.resources.metrics.each.info.withPathMixin

```ts
withPathMixin(value)
```



####### obj spec.resources.metrics.each.stateSet


######## fn spec.resources.metrics.each.stateSet.withLabelName

```ts
withLabelName(value)
```



######## fn spec.resources.metrics.each.stateSet.withLabelsFromPath

```ts
withLabelsFromPath(value)
```



######## fn spec.resources.metrics.each.stateSet.withLabelsFromPathMixin

```ts
withLabelsFromPathMixin(value)
```



######## fn spec.resources.metrics.each.stateSet.withList

```ts
withList(value)
```



######## fn spec.resources.metrics.each.stateSet.withListMixin

```ts
withListMixin(value)
```



######## fn spec.resources.metrics.each.stateSet.withPath

```ts
withPath(value)
```



######## fn spec.resources.metrics.each.stateSet.withPathMixin

```ts
withPathMixin(value)
```



######## fn spec.resources.metrics.each.stateSet.withValueFrom

```ts
withValueFrom(value)
```



######## fn spec.resources.metrics.each.stateSet.withValueFromMixin

```ts
withValueFromMixin(value)
```


