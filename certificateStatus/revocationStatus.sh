issuer_dn="UID=c-CEJHfOUpRPS3Ms3gWyMJqCax3aoXmCwu,CN=ManagementCA,O=Example%20CA,C=SE"
cert_serial="19F25BF2ADA9D577BCC1B1CF204CBD8FE5CE0093"

client_cert="/home/bruno/Downloads/superadmin.p12:Bitnami1234"

hostname="localhost"


curl -X GET -k -v\
    --cert-type P12 \
    --cert "$client_cert" \
    -H 'Content-Type: application/json' \
    "https://$hostname:8443/ejbca/ejbca-rest-api/v1/certificate/$issuer_dn/$cert_serial/revocationstatus"
