#!/usr/bin/env bash

# Generates a wildcard certificate for a given domain name.


set -e


if [ -z "$1" ]; then
    echo -e "Missing domain name!"
    echo
    echo "Usage: $0 <DOMAIN=example.com> <ORGANIZATION=Local Development>"
    echo
    echo "This will generate a wildcard certificate for the given domain name and its subdomains."
    exit
fi

ca_key=ca.key
ca_cert=ca.crt

DOMAIN=$1
ORG_NAME="Local Development"
[ ! -z "$2" ] && ORG_NAME=$2


if [ ! -f $ca_key ]; then
    echo -e "Certificate Authority private key does not exist!"
    echo
    echo -e "Please run create-ca.sh first."
    exit
fi

# Generate a private key
openssl genrsa -out "$DOMAIN.key" 4096

# Create a certificate signing request
openssl req \
	-new \
	-subj "/C=US/O=${ORG_NAME}/CN=$DOMAIN" \
	-key "$DOMAIN.key" \
	-out "$DOMAIN.csr"

# Create a config file for the extensions
>"$DOMAIN.ext" cat <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth, clientAuth
subjectAltName = @alt_names
[alt_names]
DNS.1 = $DOMAIN
DNS.2 = *.$DOMAIN
EOF

# Create the signed certificate
openssl x509 -req \
    -in "${DOMAIN}.csr" \
    -extfile "${DOMAIN}.ext" \
    -CA "${ca_cert}" \
    -CAkey "${ca_key}" \
    -CAcreateserial \
    -out "${DOMAIN}.crt" \
    -days 365 \
    -sha256

rm "$DOMAIN.csr"
rm "$DOMAIN.ext"

echo -e "Success!"
echo
echo -e "You can now use $DOMAIN.key and $DOMAIN.crt in your web server."
echo -e "Don't forget that you must have imported ${CA_CERT} in your browser to make it accept the certificate."
