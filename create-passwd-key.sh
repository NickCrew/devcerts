#!/usr/bin/env bash
#
# Generate a password-protected private key
#

set -e

name="client"
[ ! -z "$1" ] && name="$1"
outfile = "${name}.key"

openssl genrsa -des3 -out $outfile 4096
