#!/bin/bash

# To check the routing configuration use the `ip route show` command
ip route show

# default via 10.0.1.1 dev enp1s0 proto static metric 100 
# 10.10.10.0/24 dev enp7s0 proto kernel scope link src 10.10.10.20 metric 101 
# 192.168.122.0/24 dev enp1s0 proto kernel scope link src 192.168.122.248 

# To add a route to destination network use the `ip route add` command
ip route add 10.20.20.0/24 via 10.10.10.1 

# Use the `ip route show` command to verify the route is added
ip route show

# default via 10.0.1.1 dev enp1s0 proto static metric 100 
# 10.10.10.0/24 dev enp7s0 proto kernel scope link src 10.10.10.20 metric 101 
# 10.20.20.0/24 via 10.10.10.1 dev enp7s0 
# 192.168.122.0/24 dev enp1s0 proto kernel scope link src 192.168.122.248 
