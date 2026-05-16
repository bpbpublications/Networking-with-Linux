#!/bin/bash


# To create a VLAN based subinterface for an interface e.g eth0 add link with type vlan and a VLAN ID
# ip link add link eth0 name eth0.10 type vlan id 10   

# Add a bridge device
ip link add br0 type bridge  

# Create 2 virtual networks
# - nodeXeth0 for the node side of the network
# - nodeXbr for the bridge side of the network
# Connect the nodeXeth0 to the bridge
# Create a VLAN subinterface for the nodeXeth0 and assign IP Address 
ip link add node3eth0 type veth peer name node3br  
ip link set node3eth0 up  
ip link set node3br up  
ip link set node3br master br0  

ip link add link node3eth0 name node3eth0.10 type vlan id 10  
ip link set node3eth0.10 up  
ip addr add dev node3eth0.10 10.10.0.3/24  

ip link add node4eth0 type veth peer name node4br  
ip link set node4br up  
ip link set node4eth0 up  
ip link set node4br master br0  

ip link add link node4eth0 name node4eth0.10 type vlan id 10  
ip link set node4eth0.10 up  
ip addr add dev node4eth0.10 10.10.0.4/24 
ip link set br0 up   

echo 1|tee /proc/sys/net/ipv4/conf/all/accept_local

# Use ping and tcp dump to check connectivity and check packet flow
ping -c3 -I node4eth0.10 10.10.0.3  

#tcpdump -n -i node4eth0 -e  


