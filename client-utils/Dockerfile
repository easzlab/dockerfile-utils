FROM debian:bookworm-slim
ENV LANG C.UTF-8
ENV TZ=Asia/Shanghai
ENV DEBIAN_FRONTEND=noninteractive

# runtime dependencies
RUN set -eux; \
    echo '' > /etc/apt/sources.list.d/debian.sources; \
    echo 'deb http://mirrors.aliyun.com/debian/ bookworm main non-free non-free-firmware contrib' > /etc/apt/sources.list; \
    echo 'deb-src http://mirrors.aliyun.com/debian/ bookworm main non-free non-free-firmware contrib' >> /etc/apt/sources.list; \
    echo 'deb http://mirrors.aliyun.com/debian-security/ bookworm-security main' >> /etc/apt/sources.list; \
    echo 'deb-src http://mirrors.aliyun.com/debian-security/ bookworm-security main' >> /etc/apt/sources.list; \
    echo 'deb http://mirrors.aliyun.com/debian/ bookworm-updates main non-free non-free-firmware contrib' >> /etc/apt/sources.list; \
    echo 'deb-src http://mirrors.aliyun.com/debian/ bookworm-updates main non-free non-free-firmware contrib' >> /etc/apt/sources.list; \
    echo 'deb http://mirrors.aliyun.com/debian/ bookworm-backports main non-free non-free-firmware contrib' >> /etc/apt/sources.list; \
    echo 'deb-src http://mirrors.aliyun.com/debian/ bookworm-backports main non-free non-free-firmware contrib' >> /etc/apt/sources.list; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
	ca-certificates \
        # db clients
    	default-mysql-client \
    	redis-tools \
    	postgresql-client \
        clickhouse-client

COPY download.sh .
ENV OSS_VER=v1.7.18
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
	netbase \
	tzdata \
        curl \
        procps \
        net-tools \
	wget \
        unzip \
    && apt-get autoremove -y && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && sh -x ./download.sh

WORKDIR /app
