#!/bin/bash

# Create a filter table and add a chain input: 

nft add table inet filter  
nft add chain inet filter input { type filter hook input priority 0 \; }  

 

# Create sets for allowed and blocked IPs: 
nft add set inet filter allowed_ips { type ipv4_addr \; flags interval \; }  
nft add set inet filter blocked_ips { type ipv4_addr \; }  

 

# Populate the sets with IPs: 
nft add element inet filter allowed_ips { 192.168.1.0/24, 10.0.0.0/8 }  
nft add element inet filter blocked_ips { 45.227.253.109, 185.142.236.34 }  


# Add rules to accept allowed IPs and drop blocked ones: 
nft add rule inet filter input ip saddr @allowed_ips accept  
nft add rule inet filter input ip saddr @blocked_ips drop 

 

# View the chain configuration:  

nft -a list chain inet filter input  

# table inet filter { 
#         chain input { # handle 1 
#                 type filter hook input priority filter; policy accept; 
#                 ip saddr @allowed_ips accept # handle 10 
#                 ip saddr @blocked_ips drop # handle 11 
#         } 
# } 

 

# List the sets defined with the list sets command as follows: 

nft list sets  

# table ip filter { 
# } 
# table inet filter { 
#         set allowed_ips { 
#                 type ipv4_addr 
#                 flags interval 
#                 elements = { 10.0.0.0/8, 192.168.1.0/24 } 
#         } 
#         set blocked_ips { 
#                 type ipv4_addr 
#                 elements = { 45.227.253.109, 185.142.236.34 } 
#         } 
# } 
