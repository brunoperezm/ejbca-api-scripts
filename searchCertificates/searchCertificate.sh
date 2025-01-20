client_cert="/home/bruno/Downloads/new_superadmin.p12:Bitnami1234"

hostname="localhost"

json_payload='{"max_number_of_results": 20, "criteria":[{"property":"END_ENTITY_PROFILE", "operation": "EQUAL", "value": "EMPTY"}]}'

echo $json_payload

curl -X POST -k -v\
    --cert-type P12 \
    --cert "$client_cert" \
    -H 'Content-Type: application/json' \
    --data "$json_payload" \
    "https://$hostname:8443/ejbca/ejbca-rest-api/v1/certificate/search"
