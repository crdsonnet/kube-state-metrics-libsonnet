#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

DIRNAME="$(dirname "$0")"

jsonnet -J vendor "${DIRNAME}/custommetrics.jsonnet" > "${DIRNAME}/custommetrics.yaml"

kube-state-metrics \
    --port=8080 \
    --telemetry-port=8081 \
    --kubeconfig="${HOME}/.kube/config" \
    --custom-resource-state-only \
    --custom-resource-state-config-file "${DIRNAME}/custommetrics.yaml"
