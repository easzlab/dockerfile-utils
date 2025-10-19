#!/bin/sh

set -eux

ARC=$(uname -m)
ARCH="amd64"

case "$ARC" in
  x86_64)
      ARCH="amd64"
      ;;
  aarch64)
      ARCH="arm64"
      ;;
  ?)
      echo "error: not supported platform right now, exit"
      exit 1
      ;;
esac

wget https://github.com/aliyun/ossutil/releases/download/${OSS_VER}/ossutil-${OSS_VER}-linux-${ARCH}.zip && \
unzip ossutil-${OSS_VER}-linux-${ARCH}.zip && \
mv ossutil-${OSS_VER}-linux-${ARCH}/ossutil64 /usr/bin/ossutil && \
rm -rf ossutil-${OSS_VER}-linux-${ARCH}*
