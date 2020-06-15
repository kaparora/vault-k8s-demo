#tests
#kubectl run --generator=run-pod/v1 tmp --rm -i --tty \
#     --serviceaccount=vault-auth --image dwdraju/alpine-curl-jq

#KUBE_TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
#echo $KUBE_TOKEN
#curl --request POST --data '{"jwt": "'"$KUBE_TOKEN"'", "role": "myrole"}' http:
#//vault:8200/v1/auth/kubernetes/login | jq