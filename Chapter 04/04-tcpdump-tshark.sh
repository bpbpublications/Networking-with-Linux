
# Basic format of tcpdump command
# tcpdump [options] [filter expression]

# Use tcpdump to listen for traffic on port 80 on interface eth0
tcpdump -i eth0 port 80 –nn 

# Use tcpdump with host based filter
# - host: to match local ro remote host address
tcpdump host 192.168.1.100   
# - src host: for source host
tcpdump src host 192.168.1.100    
# - dst host: for destination host
tcpdump dst host 192.168.1.100    


# Use tcpdump with network based filter
# - net: to match local ro remote network address
tcpdump net 192.168.1.0/24        
# - src net: for source network
tcpdump src net 10.0.0.0/8        
# - dst net: for destination network
tcpdump dst net 172.16.0.0/16 

# Use tcpdump with port based filter
# - port: to match local ro remote port
tcpdump port 80                  
# - src port: to match source port
tcpdump src port 22               
# - dst port: to match destination port
tcpdump dst port 53 

# Use tcpdump with portrange to filter for port range e.g. 1000-2000
tcpdump portrange 1000-2000 

# use protocol based filter e.g. icmp
tcpdump icmp 

# Filter connection based on state
tcpdump 'tcp[tcpflags] & tcp-syn != 0'    
tcpdump 'tcp[tcpflags] & tcp-ack != 0'    
tcpdump 'tcp[tcpflags] & tcp-fin != 0'    

# filter base on packet size e.g. less then 64 bytes or grater then 1500 bytes
tcpdump less 64                   
tcpdump greater 1500      
tcpdump length = 128 


# use tcpdump with combination of filters 
tcpdump 'src host 192.168.1.100 and dst port 80'  
tcpdump 'host 192.168.1.100 and not port 22' 
tcpdump '(src net 10.0.0.0/8 and dst port 443) or (src net 172.16.0.0/16 and dst port 80)' 
tcpdump 'port 53 and udp and host example.com' 

# Use tcpdump to save the packet captures into a file or analyse the a capture file
tcpdump -w /tmp/dump.pcap
tcpdump -r /tmp/dump.pcap

# Limit size of capture file by size of count
tcpdump -G 60 -w /tmp/dump.pcap 
tcpdump -C 100 -w /tmp/dump.pcap

tcpdump -n -c 3 src host 192.168.122.1 and dst port 22

# Use tshark to capture packets 
tshark -n -c 3 src host 192.168.122.1 and dst port 22 


