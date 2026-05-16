#!/bin/bash

for i in {1..2}; do
    node=node$i
   docker run --rm=true -d --name=${node} --privileged \
	   -v ${PWD}/config/${node}_ipsec.conf:/etc/ipsec.conf \
	   -v ${PWD}/config/${node}_ipsec.secrets:/etc/ipsec.secrets \
	   -v ${PWD}/certs:/etc/ipsec.d/certs \
	   -v ${PWD}/certs:/etc/ipsec.d/private \
	   -v ${PWD}/certs:/etc/ipsec.d/cacerts \
	   ipsecnodecerts:latest sleep infinity
done
