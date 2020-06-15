#!/bin/sh
set -o xtrace

#test
kubectl delete po curl-kapil
kubectl run curl-kapil \
--image=dwdraju/alpine-curl-jq \
 --restart=Never \
 -- curl -s http://vault:8200/v1/sys/seal-status
sleep 5
kubectl logs curl-kapil | jq
kubectl delete po curl-kapil