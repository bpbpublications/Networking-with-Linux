#!/bin/bash

flanneld -etcd-endpoints 172.17.0.2:2379 > /tmp/log 2>&1
