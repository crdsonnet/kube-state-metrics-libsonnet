# kube-state-metrics-libsonnet

This project provides a jsonnet library for configuring
[kube-state-metrics](https://github.com/kubernetes/kube-state-metrics) and installing it
on Kubernetes.

The ksmCustom library provides a way to configure [Custom Resource State Metrics](https://github.com/kubernetes/kube-state-metrics/blob/main/docs/customresourcestate-metrics.md),
it is generated from a JSON schema derived from the Go structs in
kube-state-metrics. The kube-state-metrics library is manually curated.

## Docs

See docs to [configure Custom Resource State Metrics](./ksm-custom/docs/README.md) and
[install kube-state-metrics](./kube-state-metrics/docs/README.md).
