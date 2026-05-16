#!/bin/bash


# Add custom routing tables if they don't already exist
grep -q "101 custom1" /etc/iproute2/rt_tables || echo "101 custom1"|sudo tee -a /etc/iproute2/rt_tables 
grep -q "102 custom2" /etc/iproute2/rt_tables || echo "102 custom2"|sudo tee -a /etc/iproute2/rt_tables 

# Add specific routes to the custom routing tables
# Route to 172.16.10.1 via 192.168.122.248 in table custom1
ip route add 172.16.10.1/32 via 192.168.122.248 table custom1 
# Route to the SAME IP via different gateway in table custom2
ip route add 172.16.10.1/32 via 10.10.10.20 table custom2

# Verify the routes in both custom tables
ip route show table custom1
ip route show table custom2

# Create policy routing rules based on TCP port
# Route all TCP traffic destined to port 5000 through table custom1
ip rule add ipproto tcp dport 5000 lookup custom1
# Route all TCP traffic destined to port 6000 through table custom2
ip rule add ipproto tcp dport 6000 lookup custom2
# Display all routing rules (including these new ones)
ip rule show

# Start Python HTTP servers on specific IP and ports
# Server on port 5000 bound to 172.16.10.1
python3 -m http.server --bind 172.16.10.1 5000 & 
# Server on port 6000 bound to the same IP
python3 -m http.server --bind 172.16.10.1 6000 &

# Test connectivity to both servers
# Curl to port 5000 (will use custom1 routing table via 192.168.122.248)
curl -s http://172.16.10.1:5000 >/dev/null 
# Curl to port 6000 (will use custom2 routing table via 10.10.10.20)
curl -s http://172.16.10.1:6000 >/dev/null