# Developer Certificates

Generate site and client certificates using OpenSSL.

## Usage 


### Certificate Authority

Create the Certificate Authority. You only need to do this once. 

````bash
./create-ca.sh
````
Files Generated:
- `ca.crt` - The root certificate
- `ca.key` - The root certificates' private key
- `ca.srl` - The CA serial

---

### Site Certificates

Issue a wildcard site certificate. Works for `*.example.com`. 

````bash
./create-site-certificate.sh example.com
````

Files generated:  
- `example.com.crt` - The site certificate
- `example.coom.key` - THe site certificate's private key

---

### Client Certificates

These are client certificates for mutual TLS (mTLS).  

Create a  CA if needed and then issue a client certificate.

````bash
./create-client-certificate.sh user
````

> __NOTE:__ If you want to password protect the user's key, generate the key with `create-passwd-key.sh` before running `create-client-certificate.sh`  

You can create a PFX if you'd like.
````bash
./create-client-pfx user.pfx ca.crt user.key user.crt
````

Files Generated:
- `user.key` - The user's private key
- `user.crt` - The user's client certificate
- `user.pfx` - The PFX bundle (if you created one)
---





