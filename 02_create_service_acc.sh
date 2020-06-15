#!/bin/sh
set -o xtrace
kubectl delete serviceaccount vault-auth
kubectl create serviceaccount vault-auth
kubectl apply --filename vault-auth-service-account.yaml
