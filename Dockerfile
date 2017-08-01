FROM ubuntu:16.04 
MAINTAINER XJD 25635680@qq.com

# Confd information. 
ENV ETCD_VERSION v2.3.7
ENV CONFD_VERSION 0.11.0 
ENV ETCD_CLIENT_IP etcd_client_ip
ENV CLUSTER cluster_name

RUN apt-get update && apt-get install -y wget --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install etcdctl.
RUN wget https://github.com/coreos/etcd/releases/download/${ETCD_VERSION}/etcd-${ETCD_VERSION}-linux-amd64.tar.gz --no-check-certificate && \
    tar xvzf etcd-${ETCD_VERSION}-linux-amd64.tar.gz && \
    mv etcd-${ETCD_VERSION}-linux-amd64/etcdctl /usr/local/bin/etcdctl && \
    rm -rf etcd-${ETCD_VERSION}-linux-amd64
 
# Install Confd.
RUN wget https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 --no-check-certificate && \
    chmod +x confd-${CONFD_VERSION}-linux-amd64 && \
    mv confd-${CONFD_VERSION}-linux-amd64 /usr/local/bin/confd && \
    mkdir /etc/ceph

# Copy configuration file.
COPY ./confd /etc/confd
COPY ./setup.sh /

CMD ["/setup.sh"]
