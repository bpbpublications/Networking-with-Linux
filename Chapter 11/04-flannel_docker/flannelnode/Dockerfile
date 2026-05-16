FROM ubuntu:rolling
RUN apt update && apt install -y iproute2 iputils-ping bind9-dnsutils
RUN apt install -y netcat-openbsd
ADD ./flanneld-amd64 /usr/bin/flanneld
ADD ./start-flannel.sh /root/start-flannel.sh
ADD ./test-flannel.sh /root/test-flannel.sh

CMD ["sleep", "infinity"]
