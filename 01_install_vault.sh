#!/bin/sh
set -o xtrace
helm delete vault
helm repo add hashicorp https://helm.releases.hashicorp.com
#helm install vault hashicorp/vault --version 0.6.0

helm install \
  vault \
  hashicorp/vault \
  -f vault-helm-values.yaml \
  --version 0.6.0

