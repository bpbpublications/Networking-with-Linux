#!/bin/bash

# To check the network interface card use lspci to list PCI cards on the machine
# and filter the Ethernet cards

lspci|grep Ethernet 

# 01:00.0 Ethernet controller: Red Hat, Inc. Virtio 1.0 network device (rev 01)

# Use ethtool to check the properties of the network interface e.g. enp1s0
sudo ethtool enp1s0

# Settings for enp1s0:
# 	Supported ports: [  ]
# 	Supported link modes:   Not reported
# 	Supported pause frame use: No
# 	Supports auto-negotiation: No
# 	Supported FEC modes: Not reported
# 	Advertised link modes:  Not reported
# 	Advertised pause frame use: No
# 	Advertised auto-negotiation: No
# 	Advertised FEC modes: Not reported
# 	Speed: Unknown!
# 	Duplex: Unknown! (255)
# 	Auto-negotiation: off
# 	Port: Other
# 	PHYAD: 0
# 	Transceiver: internal
# 	Link detected: yes


# Use the -S switch to vies the static for the network card
sudo ethtool -S enp1s0

# NIC statistics:
#      rx_queue_0_packets: 2672
#      rx_queue_0_bytes: 205962
#      rx_queue_0_drops: 0
#      rx_queue_0_xdp_packets: 0
#      rx_queue_0_xdp_tx: 0
#      rx_queue_0_xdp_redirects: 0
#      rx_queue_0_xdp_drops: 0
#      rx_queue_0_kicks: 1
#      tx_queue_0_packets: 1143
#      tx_queue_0_bytes: 220704
#      tx_queue_0_xdp_tx: 0
#      tx_queue_0_xdp_tx_drops: 0
#      tx_queue_0_kicks: 1072
#      tx_queue_0_tx_timeouts: 0
