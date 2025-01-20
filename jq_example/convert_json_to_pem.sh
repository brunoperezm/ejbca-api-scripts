#!/bin/sh

user_id=$1
hsm_pin=$2
token_label=$3
hsm_module_path=$4
base64file=$(mktemp)
bin_cert_file=$(mktemp)
bin_pem_file=$(mktemp)
# Convert the json input to a base 64 file
jq -r .certificate > $base64file
# Convert the b64 input to a cert binary file
openssl base64 -d -A -in $base64file -out $bin_cert_file
# Convert raw binary cert to pem encoded
openssl x509 -inform der -in $bin_cert_file -out $bin_pem_file

pkcs11-tool --module=$hsm_module_path --token-label $token_label --login \
    --pin $hsm_pin --label user_$user_id --id $user_id \
    --write-object $bin_pem_file --type cert 

cat $bin_pem_file

rm $base64file $bin_cert_file $bin_pem_file