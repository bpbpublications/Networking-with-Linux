#!/bin/bash

# To test STP we will create 3 bridges
sudo ip link add name br1 type bridge  
sudo ip link add name br2 type bridge  
sudo ip link add name br3 type bridge  


# Enable STP on each of the bridge
sudo ip link set br1 type bridge stp_state 1  
sudo ip link set br2 type bridge stp_state 1  
sudo ip link set br3 type bridge stp_state 1 

# Create 3 virtual networks
sudo ip link add veth1-br1 type veth peer name veth1-br2  
sudo ip link add veth2-br2 type veth peer name veth2-br3  
sudo ip link add veth3-br3 type veth peer name veth3-br1  

# Use the virtual networks to connect the bridges so that each bridge is connected to the other two
sudo ip link set veth1-br1 master br1  
sudo ip link set veth1-br2 master br2  
sudo ip link set veth2-br2 master br2  
sudo ip link set veth2-br3 master br3  
sudo ip link set veth3-br3 master br3  
sudo ip link set veth3-br1 master br1 

# Bring up all the bridges and network interfaces
sudo ip link set br1 up  
sudo ip link set br2 up  
sudo ip link set br3 up  

sudo ip link set veth1-br1 up  
sudo ip link set veth1-br2 up  

sudo ip link set veth2-br2 up  
sudo ip link set veth2-br3 up  

sudo ip link set veth3-br3 up  
sudo ip link set veth3-br1 up  


# Check the status of the bridges
brctl show

# Check the STP status of the bridges
brctl showstp br1
brctl showstp br2

# Bring down the connectivity between bridge br1 and br2
sudo ip link set veth1-br1 down  

# Check the STP status of the bridges
brctl showstp br1
brctl showstp br2
