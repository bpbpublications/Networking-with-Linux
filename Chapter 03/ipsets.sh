#!/bin/bash


# This IPset will retain the individual entries for 300 seconds. 
ipset create temp_block hash:ip timeout 300 

# You can add a counter to an IPset to get the number of packets that match the IPset
ipset create tracked_hosts hash:ip counters 


# Create ipset with a timeout period and add host and network addresses
ipset create malicious_hosts hash:ip timeout 86400 
ipset add malicious_hosts 192.0.2.45 
ipset add malicious_hosts 203.0.113.0/24 

# Use ipset in a iptables rule with --match-set
iptables -A INPUT -m set --match-set malicious_hosts src -j DROP


# Test to check if an ip address e.g. 8.8.8.8 is part of an ipsets
ipset create test_block hash:ip timeout 300 counters 
ipset test test_block 8.8.8.8
ipset add test_block 8.8.8.8
ipset test test_block 8.8.8.8



ipset create test_block hash:ip timeout 300 counters 
ipset add test_block 8.8.8.8 
iptables -A INPUT -m set --match-set test_block src -j DROP 
ipset list test_block 
# Name: test_block 
# Type: hash:ip 
# Revision: 6 
# Header: family inet hashsize 1024 maxelem 65536 timeout 300 counters bucketsize 12 initval 0xf149a303 
# Size in memory: 312 
# References: 1 
# Number of entries: 1 
# Members: 
# 8.8.8.8 timeout 208 packets 0 bytes 0 


# Test the performance of a large ipset match
ipset create large_set hash:ip 
for i in {1..40}; do ipset add large_set 10.10.0.$i; done 
for i in {1..40}; do ipset add large_set 10.20.0.$i; done 
time bash -c "for i in {1..1000}; do ipset test large_set 10.10.0.$((RANDOM%256)); done" 