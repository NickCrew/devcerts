#!/usr/bin/env bash

# Generates your own Certificate Authority for development.
# This script should be executed just once.

set -e

ca_cert="ca.crt"
ca_key="ca.key"

subject=
expiration=365 # In Days

if [ -f $ca_cert ] || [ -f $ca_key ]; then
    echo -e "Certificate Authority files already exist!"
    echo
    echo -e "You only need a single CA even if you need to create multiple certificates."
    echo -e "This way, you only ever have to import the certificate in your browser once."
    echo
    echo -e "If you want to restart from scratch, delete the $ca_cert and $ca_key files."
    exit
fi


# Generate private key
openssl genrsa -out $ca_key 2048

echo "Generating root certificate..."
echo "Subject: ${subject}"
echo "Expiration: ${expiration} days"

# Generate root certificate
openssl req \
	-x509 \
	-new \
	-nodes \
	-subj "/C=US/O=_Development CA/CN=Development certificates" \
	-key $ca_key \
	-sha256 \
	-days $expiration \
	-out $ca_cert

echo -e "Success!"
echo "The following files have been written:"
echo -e "  - $ca_cert"
echo -e "  -  $ca_key"
