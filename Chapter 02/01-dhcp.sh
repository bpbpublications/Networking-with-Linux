#!/bin/bash

# Create a bridge to test DHCP server
ip link add br1 type bridge 
ip link set br1 up 

# Assign IP Address to the bridge interface.
# DHCP server will use the following IP Address
ip addr add dev br1 10.5.5.1/27


# Install dhcp server package
apt install isc-dhcp-server –y 

# Configure DHCP serve to listen only on the bridge interface i.e. br1
cat <<EOF > isc-dhcp-server
# Defaults for isc-dhcp-server (sourced by /etc/init.d/isc-dhcp-server)

# Path to dhcpd's config file (default: /etc/dhcp/dhcpd.conf).
#DHCPDv4_CONF=/etc/dhcp/dhcpd.conf
#DHCPDv6_CONF=/etc/dhcp/dhcpd6.conf

# Path to dhcpd's PID file (default: /var/run/dhcpd.pid).
#DHCPDv4_PID=/var/run/dhcpd.pid
#DHCPDv6_PID=/var/run/dhcpd6.pid

# Additional options to start dhcpd with.
#	Don't use options -cf or -pf here; use DHCPD_CONF/ DHCPD_PID instead
#OPTIONS=""

# On what interfaces should the DHCP server (dhcpd) serve DHCP requests?
#	Separate multiple interfaces with spaces, e.g. "eth0 eth1".
INTERFACESv4="br1"
INTERFACESv6=""
EOF

# Configure DHCP server.
cat <<EOF > dhcpd.conf
option domain-name "example.com"; 
option domain-name-servers 8.8.8.8, 8.8.4.4; 
default-lease-time 600; 
max-lease-time 7200; 
authoritative; 

subnet 10.5.5.0 netmask 255.255.255.224 { 
    range 10.5.5.26 10.5.5.30; 
    option domain-name-servers ns1.internal.example.org; 
    option domain-name "internal.example.org"; 
    option subnet-mask 255.255.255.224; 
    option routers 10.5.5.1; 
    option broadcast-address 10.5.5.31; 
    default-lease-time 600; 
    max-lease-time 7200; 
} 

EOF

# Copy the DHCP server configuration to the correct locations
cp dhcpd.conf /etc/dhcp/dhcpd.conf
cp isc-dhcp-server /etc/default/isc-dhcp-server

# Start DHCP service
systemctl start isc-dhcp-server 


# Create a virtual network with veth pair
ip link add veth1 type veth peer veth1br1 

# Attach the virtual network to the bridge
ip link set veth1br1 master br1 

# Bring the network interfaces on the virtual network up
ip link set veth1br1 up 
ip link set veth1 up 

# Request IP address from the DHCP server.
# Use tcpdump to capture the DHCP request on another terminal with tcpdump -n -i br1  
dhclient -4 veth1 

