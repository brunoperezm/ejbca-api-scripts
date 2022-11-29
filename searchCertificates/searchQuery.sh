client_cert="/home/bruno/Downloads/superadmin.p12:Bitnami1234"

hostname="localhost"

json_payload='{"max_number_of_results": 20, "criteria":[{"property":"QUERY", "operation": "EQUAL", "value": "bruno5"}]}'

echo $json_payload

curl -X POST -k\
    --cert-type P12 \
    --cert "$client_cert" \
    -H 'Content-Type: application/json' \
    --data "$json_payload" \
    "https://$hostname:8443/ejbca/ejbca-rest-api/v1/certificate/search" > /tmp/cert.json

jq  '.certificates[0].certificate' /tmp/cert.json > /tmp/cert-base64.b64

openssl base64 -d -A -in /tmp/cert-base64.b64 -out cert.crt