FROM ubuntu:rolling

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
vim \
iproute2 \
iptables \
iputils-ping \
libcharon-extauth-plugins \
libcharon-extra-plugins \
libstrongswan libstrongswan-extra-plugins \
libstrongswan-standard-plugins \
strongswan \
strongswan-charon \
strongswan-libcharon \
strongswan-pki \
strongswan-starter \
strongswan-swanctl && rm -rf /var/lib/apt/lists/*

# Copy the configuration files into the container's /etc directory
COPY config/ipsec.conf /etc/ipsec.conf
COPY config/ipsec.secrets /etc/ipsec.secrets
COPY config/strongswan.conf /etc/strongswan.conf

# Expose the standard IKE ports
EXPOSE 500/udp 4500/udp

# Command to start strongSwan in the foreground so Docker can manage the process lifecycle
#CMD ["strongswan", "start", "--nofork"]
CMD ["sleep", "infinity"]
