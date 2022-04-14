#!/usr/bin/env sh

set -e

kubectl apply -f https://github.com/tinkerbell/tink/raw/main/config/crd/bases/tinkerbell.org_hardware.yaml
kubectl apply -f https://github.com/tinkerbell/tink/raw/main/config/crd/bases/tinkerbell.org_templates.yaml
kubectl apply -f https://github.com/tinkerbell/tink/raw/main/config/crd/bases/tinkerbell.org_workflows.yaml
