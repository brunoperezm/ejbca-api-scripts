#!/bin/sh

# Before running this script you need to do the following:

# 1. If you are contacting the CA directly:
#
#     Enable the REST API in System Configuration -> Protocol Configuration.
#
#     If you are contacting an external RA, you should enable the REST API for
#     the peer role on the CA.

hostname="localhost"

# 2. Specify profiles, CA and end entity to use for issuance

cert_profile_name="ENDUSER"
ee_profile_name="LARYCEND"
ca_name="ManagementCA"
# This user will be created if it does not exist. The status of an existing
# end entity will be set to NEW automatically.
username="bruno4"
# If the user already exists, specify the enrollment code here
enrollment_code="abc123"

# 3. Adjust the variable $client_cert to point to a client certificate.

client_cert="/home/bruno/Downloads/superadmin.p12:Bitnami1234"


email="bruno178pm@gmail.com"

openssl req -new -out server.csr -newkey rsa:2048 \
   -nodes -sha256 -keyout server.key \
   -config csr.conf

csr=$(cat server.csr)
template='{"certificate_request":$csr, "certificate_profile_name":$cp, "end_entity_profile_name":$eep, "certificate_authority_name":$ca, "username":$ee, "password":$pwd}'
json_payload=$(jq -n \
    --arg csr "$csr" \
    --arg cp "$cert_profile_name" \
    --arg eep "$ee_profile_name" \
    --arg ca "$ca_name" \
    --arg ee "$username" \
    --arg pwd "$enrollment_code" \
    "$template")
echo $json_payload
curl -X POST -k -v\
    --cert-type P12 \
    --cert "$client_cert" \
    -H 'Content-Type: application/json' \
    --data "$json_payload" \
    "https://$hostname:8443/ejbca/ejbca-rest-api/v1/certificate/pkcs10enroll"
