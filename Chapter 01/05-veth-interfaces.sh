#!/bin/bash

# To create a virtual network, create a veth pair as follows
ip link add veth0 type veth peer name veth1  

# View the 2 interfaces created by the command above. 
# The 2 interfaces act as 2 ends of the network connection. 
ip link show veth0  
ip link show veth1  

# The interfaces should be brought up before traffic can start flowing 
ip link set veth0 up  
ip link set veth1 up  

# Add IP Addresses to the interfaces
ip addr add dev veth0 10.0.10.1/24  
ip addr add dev veth1 10.0.10.2/24  

# This configuration is required to accept packet from localhost on non loopback interface
echo 1|tee /proc/sys/net/ipv4/conf/all/accept_local  

# Use ping to check the connectivity over the virtual network
ping -c3 –I veth0 10.0.10.2  

# tcpdump CLI can be use to capture the traffic flow
# tcpdump –n –i veth1 
