FROM ubuntu:rolling
RUN apt update && apt install -y iproute2 iputils-ping bind9-dnsutils
ADD  ./etcd /usr/bin/etcd
ADD  ./etcdctl /usr/bin/etcdctl
ADD  ./etcdutl /usr/bin/etcdutl
ADD  ./start-etcd.sh /root/start-etcd.sh

CMD ["sleep", "infinity"]
