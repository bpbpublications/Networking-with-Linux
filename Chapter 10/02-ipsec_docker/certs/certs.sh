#!/bin/bash

cd certs
ipsec pki --gen --type rsa --size 4096 --outform pem > ca-key.pem
ipsec pki --self --ca --lifetime 3650 --in ca-key.pem     --type rsa --dn "C=IN, O=IPsec Lab, CN=IPsec Lab Root CA"     --outform pem > ca-cert.pem
ipsec pki --gen --type rsa --size 4096 --outform pem > left-key.pem
ipsec pki --pub --in left-key.pem --type rsa |     ipsec pki --issue --lifetime 1825     --cacert ca-cert.pem     --cakey ca-key.pem     --dn "C=IN, O=IPsec Lab, CN=left.site.lab"     --san left.site.lab     --outform pem > left-cert.pem

ipsec pki --gen --type rsa --size 4096 --outform pem > right-key.pem
ipsec pki --pub --in right-key.pem --type rsa |     ipsec pki --issue --lifetime 1825     --cacert ca-cert.pem     --cakey ca-key.pem     --dn "C=IN, O=IPsec Lab, CN=right.site.lab"     --san right.site.lab     --outform pem > right-cert.pem
