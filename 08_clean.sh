#!/bin/sh
set -o xtrace
kubectl delete -f myapp.yaml
kubectl delete -f configmap.yaml
kubectl delete po curl-kapil
kubectl delete serviceaccount vault-auth
helm delete vault