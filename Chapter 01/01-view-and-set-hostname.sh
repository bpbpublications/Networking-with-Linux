#!/bin/bash

# Sttting hostname "rocky9" using the hostnamectl CLI

sudo hostnamectl hostname rocky9  

# View the current hostname with hostnamectl status command. 
# The "status" argument to the command is optional, 
# if hostnamectl is run without any argument status argument is assumed by default 
hostnamectl status

#  Static hostname: rocky9
#        Icon name: computer-vm
#          Chassis: vm 🖴
#       Machine ID: 040316b02b0f4b5384b32ab34b5b5faf
#          Boot ID: 557199a3bd134c5691f25ca00d38d4b2
#   Virtualization: kvm
# Operating System: Rocky Linux 9.5 (Blue Onyx)       
#      CPE OS Name: cpe:/o:rocky:rocky:9::baseos
#           Kernel: Linux 5.14.0-503.14.1.el9_5.x86_64
#     Architecture: x86-64
#  Hardware Vendor: QEMU
#   Hardware Model: Standard PC _Q35 + ICH9, 2009_
# Firmware Version: 1.16.3-debian-1.16.3-2


# The hostname configuration is stored in "/etc/hostname". 
# It can be viewed with the cat command.
cat /etc/hostname 

# rocky9  