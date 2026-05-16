#!/bin/bash

# Setup test interface and gateway address
ip link add eth2 type dummy 
ip addr add dev lo 10.0.0.1/24

# Create a VRF instance named 'vrf-1' associated with routing table 100
# VRF allows multiple routing tables to coexist on the same system
ip link add vrf-1 type vrf table 100 

# Bring the VRF interface up
ip link set vrf-1 up 

# Bind the physical interface eth2 to the VRF instance
# This makes eth2 part of the vrf-1 routing domain
ip link set eth2 master vrf-1 

# Assign IP address 10.0.0.2/24 to interface eth2
ip addr add 10.0.0.2/24 dev eth2 

# 5. Add a default route (0.0.0.0/0) via gateway 10.0.0.1 in the VRF context
# This route will only be visible in vrf-1's routing table
ip route add default via 10.0.0.1 vrf vrf-1 

# 6. Display the routing table specific to the vrf-1 instance
# This shows routes that are only accessible through vrf-1 interfaces
ip route show vrf vrf-1
