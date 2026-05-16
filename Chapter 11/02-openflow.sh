#!/bin/bash
BRIDGE="of-br0"
echo "=== Setting up OpenFlow Bridge: $BRIDGE ==="

#Create bridge and ports
ovs-vsctl add-br $BRIDGE 
for i in 1 2 3; do
 ovs-vsctl add-port $BRIDGE of-port$i \
   -- set interface of-port$i type=internal
 ip link set dev of-port$i up 
done

#Clear existing flows
ovs-ofctl del-flows $BRIDGE
echo "=== Adding OpenFlow Rules ==="

#Add flow rules
ovs-ofctl add-flow $BRIDGE "priority=100,arp,actions=normal"
ovs-ofctl add-flow $BRIDGE \ "priority=200,ip,nw_src=10.0.0.0/24,icmp,actions=drop"
ovs-ofctl add-flow $BRIDGE "priority=150,tcp,tp_dst=80,actions=output:2"

#Display the flows and port statistics
echo "=== Current Flows ==="
ovs-ofctl dump-flows $BRIDGE
echo "=== Port Statistics ===" 
ovs-ofctl dump-ports $BRIDGE