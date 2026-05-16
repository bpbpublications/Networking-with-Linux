#!/bin/bash


# Example netplan based network configuration on ubuntu

cat << EOF | sudo tee /etc/netplan/10-custom.yaml 
network: 
  version: 2 
  renderer: networkd 
  ethernets: 
    enp1s0: 
      addresses: 
        - 192.168.122.61/24 
      routes: 
        - to: default 
          via: 192.168.122.1 
      nameservers: 
        addresses: [192.168.122.1] 
EOF 

# Set the correct file permission for netplan config file
sudo chmod 600 /etc/netplan/10-custom.yaml  

# Use netplan apply to convert netplan configuration to systemdnetworkd service configuration
sudo netplan apply


# To view the generated configuration check the systemd config as follows

sudo cat /run/systemd/network/10-netplan-enp1s0.network

# [Match] 
# Name=enp1s0 
  
# [Network] 
# LinkLocalAddressing=ipv6 
# Address=192.168.122.61/24 
# DNS=192.168.122.1 
 
# [Route] 
# Destination=0.0.0.0/0 
# Gateway=192.168.122.1 