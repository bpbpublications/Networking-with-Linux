#!/bin/bash

# Stop ping after 4 packets
ping -c 4 example.com

# set timeout for ping requests
ping -W 2 example.com 

# set size of the ping packets with -s
ping -s 1000 example.com 

# Check the default MTU on Your System
ip link show 
 
# Use ping to check the MTU size
ping -s 1472 -M do example.com

# Use ping in flood mode to check network performence
ping -f -c 1000 destination_ip_or_hostname 

# set interval between ping packets
ping -i 0.5 example.com

# Set ttl for the ping request
ping -t 30 example.com
ping -c3 -t14 google.com 

# PING google.com (2404:6800:4002:824::200e) 56 data bytes 

# From 2404:6800:8112::1 icmp_seq=1 Time exceeded: Hop limit 
# From 2404:6800:8112::1 icmp_seq=2 Time exceeded: Hop limit 
# From 2404:6800:8112::1 icmp_seq=3 Time exceeded: Hop limit 

$ ping -c3 -t20 google.com 

# PING google.com (2404:6800:4002:824::200e) 56 data bytes 

# 64 bytes from del12s07-in-x0e.1e100.net (2404:6800:4002:824::200e): icmp_seq=1 ttl=118 time=62.3 ms 
# 64 bytes from del12s07-in-x0e.1e100.net (2404:6800:4002:824::200e): icmp_seq=2 ttl=118 time=63.1 ms 
# 64 bytes from del12s07-in-x0e.1e100.net (2404:6800:4002:824::200e): icmp_seq=3 ttl=118 time=64.3 ms 