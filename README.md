# Developer Certificates

Generate site and client certificates using OpenSSL.

## Usage 

### Site Certificates


Create the Certificate Authority. You only need to do this once. 

````bash
./create-ca.sh
````

Issue a wildcard site certificate. Works for `*.example.com`. 

````bash
./create-site-certificate.sh example.com
````

---

### Client Certificates

These are client certificates for mutual TLS (mTLS).  

Create a  CA if needed and then issue a client certificate.

````bash
./create-client-certificate.sh user
````

> __Note:__ If you want to password protect the user's key, generate the key with `create-passwd-key.sh` before running `create-client-certificate.sh`  

You can create a PFX if you'd like.
````bash
create-client-pfx user.pfx ca.crt user.key user.crt
````

---





