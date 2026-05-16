#!/bin/bash


# Bonding provides fault tolerance against link failures for network connection by
# combining multiple network links in to a single logical link.

# Bonding supports multiple modes, LACP is one of the commonly used bond mode.
# To implement a bonded interface the LACP protocol must be supported by the switch.
# We will use openVSwitch to test bonding with LACP 
# ip link add bond0 type bond mode 802.3ad  

# Ensure openvswitch is installed
apt install openvswitch-switch  


# Add 2 virtual networks for bonding.
# Both of these networks will be used to connect
# the host to the bridge to provide fault tolerance.
ip link add bond10eth0 type veth peer name ovseth0   
ip link add bond10eth1 type veth peer name ovseth1    

ip link add client-bond10 type bond mode 802.3ad   
ip link set bond10eth0 master client-bond10   
ip link set bond10eth1 master client-bond10   
ip link set bond10eth0 up   
ip link set bond10eth1 up   
ip link set client-bond10 up   
ip addr add dev client-bond10 10.10.0.3/24 

ip link set ovseth0 up   
ip link set ovseth1 up  


ip link add node1-eth0 type veth peer name node1br   
ip link set node1-eth0 up  
ip link set node1br up   
ip addr add dev node1-eth0 10.10.0.2/24  

ovs-vsctl add-br br10   
ovs-vsctl add-port br10 node1br   
ovs-vsctl add-bond br10 bond10 ovseth0 ovseth1 lacp=active   
ovs-vsctl set port bond10 lacp_system_priority=1000   
ovs-vsctl set port ovseth0 lacp_port_priority=10   
ovs-vsctl set port ovseth1 lacp_port_priority=20  
ovs-vsctl set port bond10 bond_mode=balance-tcp   

ip link set br10 up   

ovs-vsctl show  
ovs-appctl lacp/show  
ovs-appctl bond/show  

echo 1|tee /proc/sys/net/ipv4/conf/all/accept_local 

tcpdump -v -n -c3 -i client-bond10  

ping -c3 -I node1-eth0 10.10.0.3  


