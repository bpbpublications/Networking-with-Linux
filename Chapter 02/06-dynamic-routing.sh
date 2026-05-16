#!/bin/bash

# Install the FRR routing package
# apt install -y frr
# yum install -y frr 

# Check and start the frr daemon
systemctl status frr
systemctl start frr

# Update the configuration of frr to enable BGP 
sed -i 's|^bgpd=no$|bgpd=yes|' /etc/frr/daemons

# restart frr to load the updated configuration.
systemctl restart frr

# Configure the BGP instance with vtysh as shown below

vtysh 

# Hello, this is FRRouting (version 8.4.4). 

# Copyright 1996-2005 Kunihiro Ishiguro, et al. 

# ubuntu24# 
# ubuntu24# configure terminal  
# ubuntu24(config)# router bgp 65001 
# ubuntu24(config-router)# neighbor 192.168.122.248 remote-as 65002 
# ubuntu24(config-router)# exit 
# ubuntu24(config)# exit 
# ubuntu24# show running-config  

# Building configuration...  

# Current configuration: 
# ! 
# frr version 8.4.4 
# frr defaults traditional 
# hostname ubuntu24 
# log syslog informational 
# no ipv6 forwarding 
# service integrated-vtysh-config 
# ! 
# router bgp 65001 
# neighbor 192.168.122.248 remote-as 65002 
# exit 
# ! 
# end 
# ubuntu24# 
# ubuntu24# show bgp summary 

# IPv4 Unicast Summary (VRF default):
# BGP router identifier 192.168.122.61, local AS number 65001 vrf-id 0
# BGP table version 0
# RIB entries 0, using 0 bytes of memory
# Peers 1, using 724 KiB of memory

# Neighbor        V         AS   MsgRcvd   MsgSent   TblVer  InQ OutQ  Up/Down State/PfxRcd   PfxSnt Desc
# 192.168.122.248 4      65002        11        11        0    0    0 00:08:19     (Policy) (Policy) N/A

# Total number of neighbors 1
# ubuntu24# 



vtysh 

# rocky9# configure terminal  
# rocky9(config)# router bgp 65002 
# rocky9(config-router)# neighbor 192.168.122.61 remote-as 65001 
# rocky9(config-router)# exit 
# rocky9(config)# exit 
# rocky9# show bgp summary 

# IPv4 Unicast Summary (VRF default):
# BGP router identifier 172.16.10.1, local AS number 65002 vrf-id 0
# BGP table version 0
# RIB entries 0, using 0 bytes of memory
# Peers 1, using 725 KiB of memory

# Neighbor        V         AS   MsgRcvd   MsgSent   TblVer  InQ OutQ  Up/Down State/PfxRcd   PfxSnt Desc
# 192.168.122.61  4      65001         6         6        0    0    0 00:03:53     (Policy) (Policy) N/A

# Total number of neighbors 1
# rocky9# 


ip link add br1 type bridge 
ip link add veth0 type veth peer vethbr 

ip link set vethbr master br1 

ip link set vethbr up 
ip link set veth0 up 

ip link set br1 up 

ip link show br1
ip addr add dev br1 10.10.10.1/24
ip route show 

# default via 192.168.122.1 dev enp1s0 proto static  
# 10.10.10.0/24 dev br1 proto kernel scope link src 10.10.10.1 linkdown  
# 192.168.122.0/24 dev enp1s0 proto kernel scope link src 192.168.122.61 

vtysh 

Hello, this is FRRouting (version 8.4.4). 

Copyright 1996-2005 Kunihiro Ishiguro, et al. 

 

ubuntu24# configure terminal  
ubuntu24(config)# router bgp 65001 
ubuntu24(config-router)# network 10.10.10.0/24 
ubuntu24(config-router)# exit 
ubuntu24(config)# ip forwarding 
ubuntu24(config)# exit 
ubuntu24# show bgp summary  
IPv4 Unicast Summary (VRF default): 
BGP router identifier 192.168.122.61, local AS number 65001 vrf-id 0 
BGP table version 0 
RIB entries 1, using 192 bytes of memory 
Peers 1, using 724 KiB of memory 

  

Neighbor        V         AS   MsgRcvd   MsgSent   TblVer  InQ OutQ  Up/Down State/PfxRcd   PfxSnt Desc 
192.168.122.248 4      65002        26        26        0    0    0 00:23:50     (Policy) (Policy) N/A 
  

Total number of neighbors 1 
ubuntu24# 

[chandan@rocky9 ~]$ sudo vtysh 

Hello, this is FRRouting (version 8.5.3). 
Copyright 1996-2005 Kunihiro Ishiguro, et al. 

rocky9# configure terminal  
rocky9(config)# route-map PERMIT-ALL permit 10 
rocky9(config-route-map)# exit 
rocky9(config)# router bgp 65002 
rocky9(config-router)# neighbor 192.168.122.61 route-map PERMIT-ALL in 
rocky9(config-router)# neighbor 192.168.122.61 route-map PERMIT-ALL out 
rocky9(config-router)# exit 
rocky9(config)# exit 
rocky9# show bgp summary  
IPv4 Unicast Summary (VRF default): 

BGP router identifier 192.168.122.248, local AS number 65002 vrf-id 0 
BGP table version 5 
RIB entries 1, using 192 bytes of memory 
Peers 1, using 725 KiB of memory 
Neighbor        V         AS   MsgRcvd   MsgSent   TblVer  InQ OutQ  Up/Down State/PfxRcd   PfxSnt Desc 
192.168.122.61  4      65001        75        75        0    0    0 01:04:49            1        1 N/A 

Total number of neighbors 1 

rocky9# 
rocky9# show ip route  
Codes: K - kernel route, C - connected, S - static, R - RIP, 
       O - OSPF, I - IS-IS, B - BGP, E - EIGRP, N - NHRP, 
       T - Table, v - VNC, V - VNC-Direct, F - PBR, 
       f - OpenFabric, 
       > - selected route, * - FIB route, q - queued, r - rejected, b - backup 
       t - trapped, o - offload failure 
  

K>* 0.0.0.0/0 [0/100] via 192.168.122.1, enp1s0, 06:02:31 
B>* 10.10.10.0/24 [20/0] via 192.168.122.61, enp1s0, weight 1, 00:04:55 
C>* 192.168.122.0/24 is directly connected, enp1s0, 06:02:31 

rocky9# 

 
[chandan@rocky9 ~]$ ip route show 
default via 192.168.122.1 dev enp1s0 proto static metric 100  
10.10.10.0/24 nhid 8 via 192.168.122.61 dev enp1s0 proto bgp metric 20  
192.168.122.0/24 dev enp1s0 proto kernel scope link src 192.168.122.248 metric 100  


 
[chandan@rocky9 ~]$ ping -c3 10.10.10.1 