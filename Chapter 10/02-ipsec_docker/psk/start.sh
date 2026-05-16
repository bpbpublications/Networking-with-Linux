#!/bin/bash

for i in {1..2}; do
    node=node$i
   docker run --rm=true -d --name=${node} --privileged -v ${PWD}/config/${node}_ipsec.conf:/etc/ipsec.conf -v ${PWD}/config/${node}_ipsec.secret:/etc/ipsec.secret ipsecnodepsk:latest sleep infinity
done
