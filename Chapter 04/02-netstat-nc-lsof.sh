#!/bin/bash

# List all network connection 
netstat -a|head -30 

# List all listening sockets using TCP protocol
netstat -ltn 

# List all listening sockets using TCP protocol along with program name and pid (requires root access)
netstat –ltnp

# Show network statistics
netstat -s


# Check connectivity to port e.g. 80 on host e.g. example.com
nc -zv example.com 80 
nc -zv localhost 8000 

# Test connectivity for UDP port e.g. 53 (DNS service)
nc -zvu 192.168.122.1 53 

# Check for open ports in a given range e.g. 2600-2607
nc -zv localhost 2600-2607  


# Use nc to connect to a HTTP service running on port 4000 and send GET request
echo -e "GET /\n\n" |nc localhost 4000

# Use nc to listen on a port e.g. 8000
nc -l -p 8080 

# use nc to send a response to request sent on listening port e.g. 4000
cat index.html |nc -l 4001

# Use nc to copy a file from one host to another
# - first use nc on the receiving host to open port 1234
# and redirect the output to destination file
nc -l -p 1234 > file 
# - next use nc on the sending host to connect to the port 1234 on the receiving host
# and redirect input from the file to be copied
nc [receiving-host-ip] 1234 < file 


# Use ss to list listening ports for TCP and UDP along with program names that listens on the port
ss -tulnp 

# Use ss to list connections by state e.g. connected
ss -t state connected 

# Use ss to filter connections by source port e.g. ssh and destination address e.g. 192.168.122.1
ss -p  '( sport = :ssh and dst = 192.168.122.1 )' 



# Use lsof to list network connections
lsof -i 

# Use lsof to list connections using UDP protocol and provide numeric output
lsof -i UDP -n 

# Use lsof to list network ports in listening mode and provide numeric output
lsof -i -s TCP:LISTEN -n


lsof -i -nP| awk '!/COMMAND/{print $1,$2,$5,$8}' | sort | uniq -c | sort -rn|head -10


