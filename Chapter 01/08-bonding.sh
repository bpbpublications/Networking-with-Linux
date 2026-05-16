#!/bin/bash

# Bonding provides fault tolerance against link failures for network connection by
# combining multiple network links in to a single logical link.

# Ensure that the kernal module for link bonding is loaded. 
modprobe bonding   


# Add a bridge device
ip link add dev br0 type bridge

# Add 2 virtual networks for bonding.
# Both of the network will be used to connect
# the host to the bridge to provide fault tolerance.

ip link add bond1eth0 type veth peer name bond1br  
ip link add bond2eth0 type veth peer name bond2br  
ip link set bond1br up  
ip link set bond2br up  
ip link set bond1br master br0  
ip link set bond2br master br0  

# Created a bonded interface and add both the bondXeth0 links to the bond
ip link add bond0 type bond  
ip link set bond1eth0 master bond0  
ip link set bond2eth0 master bond0   
ip link set bond1eth0 up  
ip link set bond2eth0 up  
ip link set bond0 up  
ip addr add dev bond0 10.20.0.2/24 


# Check the status of the bond interface and the bridge
cat /proc/net/bonding/bond0   
brctl show  

# Add another virtual network to test the bonded interface
ip link add node1eth0 type veth peer name node1br    
ip link set node1br master br0   
ip link set node1eth0 up  
ip link set node1br up  
ip addr add dev node1eth0 10.20.0.1/24   

echo 1|tee /proc/sys/net/ipv4/conf/all/accept_local 

# USe ping and tcpdump to test connectivity
ping -c 3 -I bond0 10.20.0.1  

# tcpdump  -i bond2eth0 -i bond1eth0 -e  


# To test the bond with a link failure, remove one of the interface from the bond
ip link set bond1eth0 nomaster  

# Check the status of the bond interface with one interface removed from the bond
cat /proc/net/bonding/bond0   

# Check the connectivity still works for the bonded interface. 
ping -c 3 -I bond0 10.20.0.1   
