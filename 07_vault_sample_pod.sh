#!/bin/sh
set -o xtrace
kubectl create serviceaccount myapp-sa
kubectl apply -f myapp.yaml --record
sleep 20
kubectl port-forward pod/vault-agent-myapp 8080:80