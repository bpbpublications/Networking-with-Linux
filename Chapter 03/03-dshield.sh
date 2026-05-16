#!/bin/bash

# DShield blocklist URL
BLOCKLIST_URL="https://www.dshield.org/block.txt"
TMP_FILE="/tmp/dshield_block.txt"

# Download latest list
wget "$BLOCKLIST_URL" -O "$TMP_FILE" || exit 1

# Create the main ipset if it does not exists.
sudo ipset list dshield_block >/dev/null 2>&1|| sudo ipset create dshield_block hash:ip hashsize 4096 maxelem 100000

# Create a temporary ipset (avoids locking the main set during updates)
sudo ipset create dshield_block_temp hash:ip hashsize 4096 maxelem 100000

# Add IPs to the temp set
grep -Eo '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' "$TMP_FILE" | while read -r ip;
do
sudo ipset add dshield_block_temp "$ip"
done

# Swap the temp set into production (minimizes downtime)
sudo ipset swap dshield_block_temp dshield_block

# Cleanup
sudo ipset destroy dshield_block_temp
rm "$TMP_FILE"

echo "DShield blocklist updated: $(date)" |sudo tee /var/log/dshield_ipset.log
