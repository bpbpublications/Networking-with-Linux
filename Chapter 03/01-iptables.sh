#!/bin/bash


# To view the iptables rules use one of the following command format

# iptables -L            # Lists all rules in the filter table 
# iptables -L -v         # Shows verbose output with packet counters 
# iptables -L -n         # Displays numeric output (no DNS resolution) 
# iptables -t nat -L     # Views rules in the NAT table 
# iptables -S            # Outputs rules in iptables-save format 

# View the firewall rules for filter table (using numaric output in verbose mode)
iptables -L -t filter -n -v


# The basic command format is: 
iptables [-t table] <command> <chain> <rule parameters> -j <target> 

# Accept ssh traffic
iptables -A INPUT -p tcp --dport 22 -j ACCEPT  

# Drop all traffic from 192.168.1.100
iptables -I INPUT 1 -s 192.168.1.100 -j DROP 


# View the rules in filter table
iptables -L -t filter -n 

# Chain INPUT (policy ACCEPT) 
# target     prot opt source               destination          
# DROP       0    --  192.168.1.100        0.0.0.0/0            
# ACCEPT     6    --  0.0.0.0/0            0.0.0.0/0            tcp dpt:22 
  
# Chain FORWARD (policy ACCEPT) 
# target     prot opt source               destination          
  
# Chain OUTPUT (policy ACCEPT) 
# target     prot opt source               destination


# Delete the 3rd rule in the INPUT chain
iptables -D INPUT 3 

# Delete the matching rule in INPUT chain
iptables -D INPUT -p tcp --dport 22 -j ACCEPT  

# Replace the 2nd rule in the OUTPUT chain with `-p icmp -j DROP`
iptables -R OUTPUT 2 -p icmp -j DROP  

# Create a new chain `CUSTOM_CHAIN`
iptables -N CUSTOM_CHAIN  

# Delete te chain `CUSTOM_CHAIN`
iptables -X CUSTOM_CHAIN  

# Flush all rules in the INPUT chain
iptables -F INPUT 


# Save and restore the iptables configuration
iptables-save > /etc/iptables.rules     # Saves current rules 
iptables-restore < /etc/iptables.rules  # Restores saved rules 