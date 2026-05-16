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
# iptables [-t table] <command> <chain> <rule parameters> -j <target> 


# Rules to allow traffic to ports 80 and 443 but deny everything else
iptables -A INPUT -p tcp --dport 80 -j ACCEPT 
iptables -A INPUT -p tcp --dport 443 -j ACCEPT 
# iptables -A INPUT -j DROP  # Default deny policy 


# Allow traffic for SSH service from hosts in network 192.168.1.0/24
iptables -A INPUT -p tcp --dport 22 -s 192.168.1.0/24 -j ACCEPT 
iptables -A INPUT -p tcp --dport 22 -j DROP 


# Use connection tracker state to match traffic.
# - Allow traffic for a eastablished and related connections
# - Drop traffic if the connection state is invalid 
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT  
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP 

# To list all the connection know to the connection tracker use the -L option
conntrack –L

# To geta realtime event about connection state changes from the connection tracker use the -E option
conntrack -E

# Configure SNAT to hide the original source address of the packet
# and use the routers external IP address as the source of the traffic
iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source 49.207.58.13 
# Use dynamic SNAT by configuring the MASQUERADE action to automatically
# use the ip configured on routers external interface
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE 

# Configure DNAT for exposing a service on an internal host
iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.1.10 