#!/bin/sh
set -o xtrace
export VAULT_ADDR=http://localhost:30000
export VAULT_TOKEN=root
vault policy write myapp-kv-ro - <<EOF
path "secret/data/myapp/*" {
    capabilities = ["read", "list"]
}
EOF
vault kv put secret/myapp/config username='appuser' \
        password='suP3rsec(et!' \
        ttl='30s'

export VAULT_SA_NAME=$(kubectl get sa vault-auth \
     -o jsonpath="{.secrets[*]['name']}")
export SA_JWT_TOKEN=$(kubectl get secret $VAULT_SA_NAME \
     -o jsonpath="{.data.token}" | base64 --decode; echo)
export SA_CA_CRT=$(kubectl get secret $VAULT_SA_NAME \
     -o jsonpath="{.data['ca\.crt']}" | base64 --decode; echo)
export K8S_URL="https://kubernetes:443"

vault auth enable kubernetes
vault write auth/kubernetes/config \
        token_reviewer_jwt="$SA_JWT_TOKEN" \
        kubernetes_host="$K8S_URL" \
        kubernetes_ca_cert="$SA_CA_CRT"

vault write auth/kubernetes/role/myrole \
        bound_service_account_names=myapp-sa \
        bound_service_account_namespaces=default \
        policies=myapp-kv-ro \
        ttl=24h

