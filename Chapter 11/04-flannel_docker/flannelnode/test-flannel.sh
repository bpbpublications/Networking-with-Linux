#!/bin/bash
#
ip netns add ns1
ip link add veth0 type veth peer name veth1
ip link set veth1 netns ns1

ip link add name flannel-br1 type bridge
ip link set flannel-br1 up

if [ ! -f /tmp/ip_addr ]; then
    ip_addr=$(ip -br addr sh flannel.1|awk '{print $3}')
    echo $ip_addr > /tmp/ip_addr
else
    ip_addr=$(cat /tmp/ip_addr)
fi

ip addr flush dev flannel.1
ip addr add $ip_addr dev flannel-br1
ip_addr_c1=$(echo $ip_addr|sed 's|0/32|10/32|g')

ip link set veth0 master flannel.1
ip link set veth0 up
    
# Configure network in namespace
ip netns exec ns1 ip link set lo up
ip netns exec ns1 ip link set veth1 up
ip netns exec ns1 ip addr add $ip_addr_c1 dev veth1

