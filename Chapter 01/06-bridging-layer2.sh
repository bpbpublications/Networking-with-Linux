#!/bin/bash

# To create a bridge for connecting multiple layer 2 networks
# use the use the `ip link add <bridge name> type bridge`
ip link add dev br0 type bridge


# View the bridge device created by the command above
ip link show dev br0 


# create 2 virtual networks with veth pairs.
# Each virtual network has 2 interfaces, 
# - node<x>eth0 is the interface that simuletes the interface connected to the node
# - node<x>br is the interface that connects to the bridge
ip link add node1eth0 type veth peer name node1br  
ip link add node2eth0 type veth peer name node2br  

# Bring the interfaces for both network up
ip link set node1eth0 up  
ip link set node2eth0 up  

ip link set node1br up  
ip link set node2br up  

# The bridge device should also be brought up
ip link set br0 up  

# Connect the bridge side of the virtual networks to the bridge
ip link set node1br master br0  
ip link set node2br master br0  


# Assign Ip address to the node side interfaces
ip addr add dev node1eth0 10.20.0.1/24  
ip addr add dev node2eth0 10.20.0.2/24   

# Allow local traffic to be accepted on non loopback interface
echo 1|tee /proc/sys/net/ipv4/conf/all/accept_local   

# Test connectivity with ping
ping -c3 -I node1eth0 10.20.0.2  
