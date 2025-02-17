# kubeStateMetrics

`kube-state-metrics` provides the manifests to configure kube-state-metrics
instances on Kubernetes.

This library is based on https://github.com/grafana/jsonnet-libs/tree/master/kube-state-metrics

## Install

```
jb install github.com/crdsonnet/kube-state-metrics-libsonnet/kube-state-metrics@master
```

## Usage

```jsonnet
local kubeStateMetrics = import "github.com/crdsonnet/kube-state-metrics-libsonnet/kube-state-metrics/main.libsonnet"
```


## Subpackages

* [utils](utils.md)

## Index

* [`fn new(namespace, name="kube-state-metrics", image="registry.k8s.io/kube-state-metrics/kube-state-metrics:v2.8.2")`](#fn-new)
* [`fn withAutomaticSharding(replicas=2)`](#fn-withautomaticsharding)
* [`fn withCustomResourceStateMetrics(customResourceStateMetrics)`](#fn-withcustomresourcestatemetrics)
* [`fn withKubeRBACProxyPolicyRules()`](#fn-withkuberbacproxypolicyrules)
* [`fn withKubernetesWatchPolicyRules()`](#fn-withkuberneteswatchpolicyrules)
* [`fn withMetricAnnotationsAllowList(allowList)`](#fn-withmetricannotationsallowlist)
* [`fn withMetricLabelsAllowList(allowList)`](#fn-withmetriclabelsallowlist)
* [`fn withPolicyRules(rules)`](#fn-withpolicyrules)
* [`fn withPolicyRulesMixin(rules)`](#fn-withpolicyrulesmixin)
* [`fn withPriorityClass(priorityClassName)`](#fn-withpriorityclass)
* [`fn withReplicas(replicas)`](#fn-withreplicas)
* [`fn withServiceAccountMetrics(metrics=["kube_serviceaccount_info"], annotationsAllowList=["*"], labelsAllowList=["*"])`](#fn-withserviceaccountmetrics)

## Fields

### fn new

```jsonnet
new(namespace, name="kube-state-metrics", image="registry.k8s.io/kube-state-metrics/kube-state-metrics:v2.8.2")
```

PARAMETERS:

* **namespace** (`string`)
* **name** (`string`)
   - default value: `"kube-state-metrics"`
* **image** (`string`)
   - default value: `"registry.k8s.io/kube-state-metrics/kube-state-metrics:v2.8.2"`

`new` provides initial manifest to deploy kube-state-metrics. By default it will
configure a ClusterRole with policy rules list/watch a bunch of Kubernetes
resources. The `namespace` is necessary to know up front provide a service account.

### fn withAutomaticSharding

```jsonnet
withAutomaticSharding(replicas=2)
```

PARAMETERS:

* **replicas** (`number`)
   - default value: `2`

`withAutomaticSharding` configures kube-state-metrics with automatic sharding enabled, this will replace the Deployment with a Statefulset.

This mode is incompatible with `withCustomResourceStateMetrics()`

### fn withCustomResourceStateMetrics

```jsonnet
withCustomResourceStateMetrics(customResourceStateMetrics)
```

PARAMETERS:

* **customResourceStateMetrics** (`object`)

`withCustomResourceStateMetrics` reconfigures kube-state-metrics to run in
'custom-resource-state-only' mode. It will then only collect metrics as provided by
the `customResourceStateMetrics` object. Policy rules will be generated based on
this object.

Other modes such as automatic sharding are incompatible with this mode.

### fn withKubeRBACProxyPolicyRules

```jsonnet
withKubeRBACProxyPolicyRules()
```


`withKubeRBACProxyPolicyRules` configures an additional policy rule for
subjectAccessReview, according to the Helm chart this is used for kube-rbac-proxy
but it is also included in the kube-state-metrics example without additional
context, so it might not be necessary.

### fn withKubernetesWatchPolicyRules

```jsonnet
withKubernetesWatchPolicyRules()
```


`withKubernetesWatchPolicyRules` configures a bunch of policy rules to watch many resources in Kubernetes.

### fn withMetricAnnotationsAllowList

```jsonnet
withMetricAnnotationsAllowList(allowList)
```

PARAMETERS:

* **allowList** (`object`)

`withMetricAnnotationsAllowList` configures a list of Kubernetes annotations keys that will be used in the resource' labels metric.

`allowList` looks like this:

```jsonnet
{
    // Structure:
    //'<plural_resourcename>': [
    //  '<labelname1>',
    //  '<labelname2>',
    //],

    // Example:
    nodes: [
      'container.googleapis.com/instance_id',
    ],
}
```

### fn withMetricLabelsAllowList

```jsonnet
withMetricLabelsAllowList(allowList)
```

PARAMETERS:

* **allowList** (`object`)

`withMetricLabelsAllowList` configures a list of additional Kubernetes label keys that will be used in the resource' labels metric.

`allowList` looks like this:

```jsonnet
{
    // Structure:
    //'<plural_resourcename>': [
    //  '<labelname1>',
    //  '<labelname2>',
    //],

    // Example:
    nodes: [
      'cloud.google.com/gke-nodepool',
      'eks.amazonaws.com/nodegroup',
    ],
}
```

### fn withPolicyRules

```jsonnet
withPolicyRules(rules)
```

PARAMETERS:

* **rules** (`array`)

`withPolicyRules` allows to configure an alternate set of policy rules.
### fn withPolicyRulesMixin

```jsonnet
withPolicyRulesMixin(rules)
```

PARAMETERS:

* **rules** (`array`)

`withPolicyRulesMixin` allows to additional policy rules.
### fn withPriorityClass

```jsonnet
withPriorityClass(priorityClassName)
```

PARAMETERS:

* **priorityClassName** (`string`)

`withPriorityClass` sets the priority class name for the workload.

### fn withReplicas

```jsonnet
withReplicas(replicas)
```

PARAMETERS:

* **replicas** (`number`)

`withReplicas` sets the replicas, only applies to automatic sharding.

### fn withServiceAccountMetrics

```jsonnet
withServiceAccountMetrics(metrics=["kube_serviceaccount_info"], annotationsAllowList=["*"], labelsAllowList=["*"])
```

PARAMETERS:

* **metrics** (`array`)
   - default value: `["kube_serviceaccount_info"]`
* **annotationsAllowList** (`array`)
   - default value: `["*"]`
* **labelsAllowList** (`array`)
   - default value: `["*"]`

`withServiceAccountMetrics` enables scraping [ServiceAccount metrics](https://github.com/kubernetes/kube-state-metrics/blob/main/docs/metrics/auth/serviceaccount-metrics.md).

`annotationsAllowList` and `labelsAllowList` is only applied along with respective `metrics`.
