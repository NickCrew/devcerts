#!/usr/bin/env bash

here=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

set -e

if [[ -z "$1" ]]; then
	client_name="client"
else
	client_name="$1"

fi
ca_cert="ca.crt"
ca_key="ca.key"
client_key="${client_name}.key"
client_csr="${client_name}.csr"
client_cert="${client_name}.crt"

# Generate client key
if [[ -f "$client_key" ]]; then
	echo "Client key already exists: ${client_key}"
else
	openssl genrsa -out $client_key 4096
fi


# Generate CSR
openssl req -new -key $client_key -out $client_csr

# Generate client cert
openssl x509 -req \
	-sha256 \
	-in $client_csr \
	-days 1000 \
	-CA $ca_cert \
	-CAkey $ca_key \
	-CAcreateserial \
    -out $client_cert

# Cleanup
[ -f $client_csr ] && rm $client_csr 


echo "Success!"
echo "Generated client certificate: ${client_cert}"
