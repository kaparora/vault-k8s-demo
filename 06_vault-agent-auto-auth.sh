#!/bin/sh
set -o xtrace
kubectl delete -f configmap.yaml
kubectl create -f configmap.yaml
kubectl get configmap myrole-vault-agent-config -o yaml