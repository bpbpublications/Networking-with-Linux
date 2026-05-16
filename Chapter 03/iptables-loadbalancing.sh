#!/bin/bash

# Create a custom chain WEIGHTED_LB
iptables -t nat -N WEIGHTED_LB 

# Add rules for traffic distribution e.g. 0.5 (50%)
# to each of the two targets 192.168.1.101 and 192.168.1.102
iptables -t nat -A WEIGHTED_LB -m statistic --mode random --probability 0.5 \ 
-j DNAT --to-destination 192.168.1.101 
iptables -t nat -A WEIGHTED_LB -m statistic --mode random --probability 0.5 \ 
-j DNAT --to-destination 192.168.1.102 

# Route incoming HTTP/HTTPS traffic to the custom chain WEIGHTED_LB
iptables -t nat -A PREROUTING -p tcp --dport 80 -j WEIGHTED_LB  
iptables -t nat -A PREROUTING -p tcp --dport 443 -j WEIGHTED_LB 

# Enable masquerading
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE 