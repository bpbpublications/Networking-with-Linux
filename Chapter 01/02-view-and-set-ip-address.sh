#!/bin/bash

# To view the current IP Address configuration on the machine use the `ip addr show` command.

ip addr show  

# 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
#     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
#     inet 127.0.0.1/8 scope host lo
#        valid_lft forever preferred_lft forever
#     inet6 ::1/128 scope host 
#        valid_lft forever preferred_lft forever
# 2: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
#     link/ether 52:54:00:8a:3c:58 brd ff:ff:ff:ff:ff:ff
#     inet 192.168.122.248/24 brd 192.168.122.255 scope global noprefixroute enp1s0
#        valid_lft forever preferred_lft forever
#     inet6 fe80::5054:ff:fe8a:3c58/64 scope link noprefixroute 
#        valid_lft forever preferred_lft forever


# To add an IP Address 10.0.0.10/8 to an interface e.g. enp1s0 use the `ip addr add` command
sudo ip addr add dev enp1s0 10.0.0.10/8  


# To confirm the ip address was configured on the interface enp1s0
# view the ip address configuration of the interface.
ip addr show dev enp1s0   

# 2: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
#     link/ether 52:54:00:8a:3c:58 brd ff:ff:ff:ff:ff:ff
#     inet 192.168.122.248/24 brd 192.168.122.255 scope global noprefixroute enp1s0
#        valid_lft forever preferred_lft forever
#     inet 10.0.0.10/8 scope global enp1s0
#        valid_lft forever preferred_lft forever
#     inet6 fe80::5054:ff:fe8a:3c58/64 scope link noprefixroute 
#        valid_lft forever preferred_lft forever


# The nmcli command from the network manager package can also be used to view and configuration network interfaces

nmcli connection show  

# NAME    UUID                                  TYPE      DEVICE   
# enp1s0  2bca3654-2ba5-3988-92ba-b5c7c41cab55  ethernet  enp1s0   
# lo      79a796db-1ff9-4595-9ea7-496252e6f7ee  loopback  lo  

# sudo nmcli connection modify "enp1s0" \
#   ipv4.method manual \
#   ipv4.addresses 192.168.122.248/24 \
#   ipv4.gateway 192.168.122.1 \
#   ipv4.dns "192.168.122.1" 