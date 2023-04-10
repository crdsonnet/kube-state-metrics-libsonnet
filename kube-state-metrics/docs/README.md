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

* [utils](kubeStateMetrics/utils.md)

## Index

* [`fn new(namespace, name='kube-state-metrics', image='registry.k8s.io/kube-state-metrics/kube-state-metrics:v2.8.2')`](#fn-new)
* [`fn withCustomResourceStateMetrics(customResourceStateMetrics)`](#fn-withcustomresourcestatemetrics)
* [`fn withKubeRBACProxyPolicyRules()`](#fn-withkuberbacproxypolicyrules)
* [`fn withKubernetesWatchPolicyRules()`](#fn-withkuberneteswatchpolicyrules)
* [`fn withPolicyRules(rules)`](#fn-withpolicyrules)
* [`fn withPolicyRulesMixin(rules)`](#fn-withpolicyrulesmixin)

## Fields

### fn new

```ts
new(namespace, name='kube-state-metrics', image='registry.k8s.io/kube-state-metrics/kube-state-metrics:v2.8.2')
```

`new` provides initial manifest to deploy kube-state-metrics. By default it will
configure a ClusterRole with policy rules list/watch a bunch of Kubernetes
resources. The `namespace` is necessary to know up front provide a service account.


### fn withCustomResourceStateMetrics

```ts
withCustomResourceStateMetrics(customResourceStateMetrics)
```

`withCustomResourceStateMetrics` reconfigures kube-state-metrics to run in
'custom-resource-state-only' mode. It will then only collect metrics as provided by
the `customResourceStateMetrics` object. Policy rules will be generated based on
this object.


### fn withKubeRBACProxyPolicyRules

```ts
withKubeRBACProxyPolicyRules()
```

`withKubeRBACProxyPolicyRules` configures an additional policy rule for
subjectAccessReview, according to the Helm chart this is used for kube-rbac-proxy
but it is also included in the kube-state-metrics example without additional
context, so it might not be necessary.


### fn withKubernetesWatchPolicyRules

```ts
withKubernetesWatchPolicyRules()
```

`withKubernetesWatchPolicyRules` configures a bunch of policy rules to watch many\n
resources in Kubernetes.


### fn withPolicyRules

```ts
withPolicyRules(rules)
```

`withPolicyRules` allows to configure an alternate set of policy rules.

### fn withPolicyRulesMixin

```ts
withPolicyRulesMixin(rules)
```

`withPolicyRulesMixin` allows to additional policy rules.
