# builder image
FROM golang:1.20 as builder
ENV TCPING_VER=v1.19.1
RUN set -x \
    && git config --global advice.detachedHead false \
    && git clone --depth 1 -b ${TCPING_VER} https://github.com/pouriyajamshidi/tcping.git \
    && cd tcping \
    && go build -tags 'netgo,osusergo' -ldflags '-s -w -extldflags "-static"' -o /tmp/tcping tcping.go statsprinter.go

# fetcher image
FROM debian:stable-slim as fetcher
COPY build/fetch_binaries.sh /tmp/fetch_binaries.sh

RUN apt-get update && apt-get install -y \
  curl \
  wget

RUN /tmp/fetch_binaries.sh

# release image
FROM alpine:3.18

RUN set -ex \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk update \
    && apk upgrade \
    && apk add --no-cache \
            apache2-utils \
            bash \
            busybox-extras \
            conntrack-tools \
            curl \
            dhcping \
            drill \
            ethtool \
            file\
            fping \
            iftop \
            iperf \
            iperf3 \
            iproute2 \
            ipset \
            iptables \
            iptraf-ng \
            iputils \
            ipvsadm \
            jq \
            libc6-compat \
            liboping \
            ltrace \
            mtr \
            net-snmp-tools \
            netcat-openbsd \
            nftables \
            ngrep \
            nmap \
            nmap-nping \
            nmap-scripts \
            openssl \
            py3-pip \
            py3-setuptools \
            scapy \
            socat \
            speedtest-cli \
            openssh \
            strace \
            tcpdump \
            tcptraceroute \
            tshark \
            util-linux \
            vim \
            git \
            websocat \
            swaks \
            perl-crypt-ssleay \
            perl-net-ssleay \
    && rm -rf /var/cache/apk/*

# Installing tcping
COPY --from=builder /tmp/tcping /usr/local/bin/tcping

# Installing ctop - top-like container monitor
COPY --from=fetcher /tmp/ctop /usr/local/bin/ctop

# Installing termshark
COPY --from=fetcher /tmp/termshark /usr/local/bin/termshark

# Installing grpcurl
COPY --from=fetcher /tmp/grpcurl /usr/local/bin/grpcurl

# Setting User and Home
USER root
WORKDIR /root
ENV HOSTNAME tshooter

# Fix permissions for OpenShift and tshark
RUN chmod -R g=u /root
RUN chown root:root /usr/bin/dumpcap

CMD ["sh", "-c", "tail -f /dev/null"]
