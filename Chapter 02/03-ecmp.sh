#!/bin/bash

# Setup 2 VMs with 2 network interfaces

# On VM1 network is configured as follows
ip -br addr sh 
# lo               UNKNOWN        127.0.0.1/8 ::1/128 
# enp1s0           UP             192.168.122.61/24 fe80::5054:ff:feee:6a84/64 
# enp7s0           UP             10.10.10.10/24 fe80::5054:ff:fe17:9ab7/64 

# On VM2 network is configured as follows
ip -br addr sh 
# lo               UNKNOWN        127.0.0.1/8 ::1/128 
# enp1s0           UP             192.168.122.248/24 fe80::5054:ff:fe8a:3c58/64 
# enp7s0           UP             10.10.10.20/24 fe80::a413:85be:b97:5f5f/64 



# On VM1 add ECMP route for the destination e.g. 172.16.10.1/32
ip route add 172.16.10.1/32 \
nexthop via 10.10.10.20 weight 1 \
nexthop via 192.168.122.248 weight 1

ip route sh
# default via 192.168.122.1 dev enp1s0 proto static 
# 10.10.10.0/24 dev enp7s0 proto kernel scope link src 10.10.10.10 
# 172.16.10.1 
# 	nexthop via 10.10.10.20 dev enp7s0 weight 1 
# 	nexthop via 192.168.122.248 dev enp1s0 weight 1 
# 192.168.122.0/24 dev enp1s0 proto kernel scope link src 192.168.122.61 

# On VM2 add the IP Address 172.16.10.1/32 to the loopback interface
ip addr add dev lo 172.16.10.1/32

# Check the ip address onciguration on VM2 after adding the above Address
ip -br addr sh 
# lo               UNKNOWN        127.0.0.1/8 172.16.10.1/32 ::1/128 
# enp1s0           UP             192.168.122.248/24 fe80::5054:ff:fe8a:3c58/64 
# enp7s0           UP             10.10.10.20/24 fe80::a413:85be:b97:5f5f/64 

# Check connectivity from VM1 using ping
ping -c 3 172.16.10.1
# PING 172.16.10.1 (172.16.10.1) 56(84) bytes of data.
# 64 bytes from 172.16.10.1: icmp_seq=1 ttl=64 time=0.865 ms
# 64 bytes from 172.16.10.1: icmp_seq=2 ttl=64 time=1.07 ms
# 64 bytes from 172.16.10.1: icmp_seq=3 ttl=64 time=0.913 ms

# --- 172.16.10.1 ping statistics ---
# 3 packets transmitted, 3 received, 0% packet loss, time 2003ms


# On VM2 start a python simple webserver with the following command
python3 -m http.server --bind 172.16.10.1 

# Access the webserver from the VM1 as follows
curl  http://172.16.10.1:8000/
