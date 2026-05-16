#!/bin/bash

docker run --rm=true --name=etcdnode1 -d etcdnode:1.0
docker run --rm=true --privileged --sysctl net.bridge.bridge-nf-call-iptables=1 --name=flannelnode1 -d flannelnode:1.0
docker run --rm=true --privileged --sysctl net.bridge.bridge-nf-call-iptables=1 --name=flannelnode2 -d flannelnode:1.0
