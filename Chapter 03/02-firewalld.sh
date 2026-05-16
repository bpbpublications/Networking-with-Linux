#!/bin/bash

# To check the status of the firewalld service use the following command: 
firewall-cmd --state 

#running 


# To get all zones, run the following command: 
firewall-cmd --get-zones 

# block dmz drop external home internal nm-shared public trusted work 

 
# The active zones can be seen with the following command: 
firewall-cmd --get-active-zones 

# public 
#   interfaces: enp1s0 enp7s0 


# To list the services that are allowed use the command:  
firewall-cmd --list-service 

# cockpit dhcpv6-client ssh 


# To allow connections to a service, use the following command: 
firewall-cmd --add-service=https 

# Success 
 

# view the services that are allowed in the zone with the following command: 
firewall-cmd --list-service 

# cockpit dhcpv6-client https ssh 
 

# Use the port parameter to add and check enabled ports as follows: 
firewall-cmd --add-port=3020/tcp 

# success 


# Check the lit of enabled ports
firewall-cmd --list-port 

# 3020/tcp 

 
# use the –list-all command to list all services zones and policies as follows: 
firewall-cmd --list-services 

