#!/bin/sh

source_pdf=$1
output_pdf=$2
final_signed_pdf=$3


python3.10 -m pyhanko sign addfields --field 1/30,30,120,120/FIRMA1 $source_pdf $output_pdf

python3.10 -m pyhanko sign addsig --field FIRMA1 pkcs11 \
    --p11-setup test-setup \
    --lib /usr/lib/softhsm/libsofthsm2.so \
    --token-label EJEMPLO --cert-label user_1234 \
    $output_pdf $final_signed_pdf