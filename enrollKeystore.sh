client_cert="/home/bruno/Downloads/superadmin.p12:Bitnami1234"

hostname="localhost"

json_payload='{"username":"bruno6","password":"abc123", "key_alg":"RSA", "key_spec":"2048"}'

echo $json_payload

curl -X POST -k -v\
    --cert-type P12 \
    --cert "$client_cert" \
    -H 'Content-Type: application/json' \
    --data "$json_payload" \
    "https://$hostname:8443/ejbca/ejbca-rest-api/v1/certificate/enrollkeystore"