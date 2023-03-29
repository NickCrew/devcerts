#!/usr/bin/env bash
#
# Create a new PFX for a user
#

set -e 

if [[ "$#" != "4" ]]; then
	echo "usage: <user.pfx> <user.key> <user.crt> <ca.crt>"
	exit 1
fi

pfx_out="client.pfx"
client_key="client.key"
client_cert="client.cer"
ca_cert="ca.crt"

[ ! -z "$1" ] && pfx_out="$1"
[ ! -z "$2" ] && ca_cert="$2"
[ ! -z "$3" ] && client_key="$3"
[ ! -z "$4"] && client_cert="$4"

openssl pkcs12 \
	-export \
	-out $pfx_out \
	-inkey $client_key \
	-in $client_cert \
	-certfile $ca_cert
