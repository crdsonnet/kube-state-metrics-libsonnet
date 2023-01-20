#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

DIRNAME="$(dirname "$0")"

kube-state-metrics \
    --port=8080 \
    --telemetry-port=8081 \
    --kubeconfig="${HOME}/.kube/config" \
    --custom-resource-state-only \
    --custom-resource-state-config-file "${DIRNAME}/custommetrics.yaml"
