client_cert="/home/bruno/Downloads/new_superadmin.p12:Bitnami1234"

hostname="localhost"

json_payload='{"max_number_of_results": 20, "criteria":[{"property":"QUERY", "operation": "EQUAL", "value": "6e5d703375a5ad8e2132ab0d563a1c34bbd4c534"}]}'

echo $json_payload

curl -X POST -k\
    --cert-type P12 \
    --cert "$client_cert" \
    -H 'Content-Type: application/json' \
    --data "$json_payload" \
    "https://$hostname:8443/ejbca/ejbca-rest-api/v1/certificate/search" > /tmp/example.json
jq -r '.certificates[0].certificate' /tmp/example.json > /tmp/cert-example.b64
base64 -d /tmp/cert-example.b64 > certificate.der
{
  echo "-----BEGIN CERTIFICATE-----"
  cat certificate.der
  echo "\n-----END CERTIFICATE-----"
} > certificate-with-header.der
openssl x509 -in certificate-with-header.der -noout -text
openssl x509 -in certificate-with-header.der -pubkey -enddate -noout