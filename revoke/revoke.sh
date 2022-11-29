client_cert="/home/bruno/Downloads/superadmin.p12:Bitnami1234"

hostname="localhost"

issuer_dn="UID=c-CEJHfOUpRPS3Ms3gWyMJqCax3aoXmCwu,CN=ManagementCA,O=Example%20CA,C=SE"
cert_serial="19F25BF2ADA9D577BCC1B1CF204CBD8FE5CE0093"

reason="KEY_COMPROMISE"
date="2022-11-28T14:07:09Z"

echo $json_payload

curl -X PUT -k -v\
    --cert-type P12 \
    --cert "$client_cert" \
    "https://$hostname:8443/ejbca/ejbca-rest-api/v1/certificate/$issuer_dn/$cert_serial/revoke?reason=$reason&date=$date"
