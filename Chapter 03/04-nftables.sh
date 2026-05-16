#!/bin/bash


# General format of the nft command is as follows
# nft (add | delete | flush) table [<family>] <name> 

# To add a table e.g. filter use the `nft add table`
nft add table inet filter 

# List the tables
nft list tables 

# table ip filter 
# table inet filter 


# Add chain to the table
nft add chain inet filter input { type filter hook input priority 0 \; }

# List chain in the filter table
nft list chain inet filter input 

# table inet filter { 
#         chain input { 
#                 type filter hook input priority filter; policy accept; 
#         } 
# } 

# Add rule to the chain
nft add rule inet filter input tcp dport {22, 80, 443} accept 

# List chain in the filter table
nft list chain inet filter input 

# table inet filter { 
#         chain input { 
#                 type filter hook input priority filter; policy accept; 
#                 tcp dport { 22, 80, 443 } accept 
#         } 
# } 


# List chain along with handle
nft -a list chain inet filter input  

# table inet filter { 
#         chain input { # handle 1 
#                 type filter hook input priority filter; policy accept; 
#                 tcp dport { 22, 80, 443 } accept # handle 3 
#         } 
# } 


# Delete rule with handle
nft delete rule inet filter input handle 3 

# List chain to confirm the deleting
nft -a list chain inet filter input  

# table inet filter { 
#         chain input { # handle 1 
#                 type filter hook input priority filter; policy accept; 
#         } 
# } 


 