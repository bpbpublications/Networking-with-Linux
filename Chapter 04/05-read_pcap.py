#=============================================================# 

# read_pcap.py 

#=============================================================# 
import dpkt 
import socket 


def read_pcap(file_path): 
    """ 
    Reads a PCAP file and prints Ethernet (MAC) and IP addresses for each packet. 
    """ 

    with open(file_path, 'rb') as f: 
        pcap = dpkt.pcap.Reader(f) 
        count = 0 
        for timestamp, buf in pcap: 
            count +=1 
            if count > 3: 
                break 
            try: 
                # Parse Ethernet frame 
                eth = dpkt.ethernet.Ethernet(buf) 

                # Print MAC addresses 
                print(f"\nTimestamp: {timestamp}") 
                print(f"Source MAC: {':'.join(f'{x:02x}' for x in eth.src)}") 
                print(f"Destination MAC: {':'.join(f'{x:02x}' for x in eth.dst)}") 

                # Check if packet contains IP 
                if isinstance(eth.data, dpkt.ip.IP): 
                    ip = eth.data 

                    # Print IP addresses 
                    src_ip = socket.inet_ntoa(ip.src) 
                    dst_ip = socket.inet_ntoa(ip.dst) 

                    print(f"Source IP: {src_ip}") 
                    print(f"Destination IP: {dst_ip}") 
                else: 
                    print("Non-IP Packet") 

            except Exception as e: 
                print(f"Error processing packet: {e}") 

if __name__ == '__main__': 
    import sys 
    if len(sys.argv) != 2: 
        print(f"Usage: {sys.argv[0]} <pcap_file>") 
        sys.exit(1) 

    read_pcap(sys.argv[1]) 
#========================================================# 

 
