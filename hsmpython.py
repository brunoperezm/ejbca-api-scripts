import pkcs11
import os
import hashlib
from pprint import pprint
from cryptography import x509
from cryptography.x509.oid import NameOID
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.asymmetric import rsa


# Initialise our PKCS#11 library
lib = pkcs11.lib("/usr/lib/softhsm/libsofthsm2.so")
token = lib.get_token(token_label='EJEMPLO')

data = b'INPUT DATA'

pprint(token.open)

# Open a session on our token
with token.open(user_pin='abc123') as session:
    # Generate an AES key in this session

    public, private = session.generate_keypair(pkcs11.KeyType.RSA, 2048)

    pprint(public) 
    pprint(private)
        # Generate a CSR
    csr = x509.CertificateSigningRequestBuilder().subject_name(x509.Name([
        # Provide various details about who we are.
        x509.NameAttribute(NameOID.COUNTRY_NAME, u"US"),
        x509.NameAttribute(NameOID.STATE_OR_PROVINCE_NAME, u"Virginia"),
        x509.NameAttribute(NameOID.LOCALITY_NAME, u"Richmond"),
        x509.NameAttribute(NameOID.ORGANIZATION_NAME, u"My Organization"),
        x509.NameAttribute(NameOID.COMMON_NAME, u"example.com"),
    ])).add_extension(
        x509.SubjectAlternativeName([
            # Describe what sites we want this certificate for.
            x509.DNSName(u"example.com"),
            x509.DNSName(u"www.example.com"),
        ]),
        critical=False,
    # Sign the CSR with the private key.
    ).sign(private, algorithm=hashes.SHA256())
    rsa.generate_private_key()