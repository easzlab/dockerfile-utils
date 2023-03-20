# build multi-platform binaries of cfssl utils
# @author:      gjmzj
# @git repo:    https://github.com/easzlab/dockerfile-utils
# @image repo:  easzlab/cfssl-utils

# build use golang:1.20
FROM golang:1.20 as builder_120
ENV CFSSL_VER=v1.6.3
RUN set -x \
    && mkdir -p /ext-bin \
    && git config --global advice.detachedHead false \
    && git clone --depth 1 -b ${CFSSL_VER} https://github.com/cloudflare/cfssl.git \
    && cd cfssl \
    && go build -tags 'netgo,osusergo,sqlite_omit_load_extension' -ldflags '-s -w -extldflags "-static"' cmd/cfssl/cfssl.go \
    && go build -tags 'netgo,osusergo,sqlite_omit_load_extension' -ldflags '-s -w -extldflags "-static"' cmd/cfssljson/cfssljson.go \
    && go build -tags 'netgo,osusergo,sqlite_omit_load_extension' -ldflags '-s -w -extldflags "-static"' cmd/cfssl-certinfo/cfssl-certinfo.go \
    && mv cfssljson cfssl-certinfo cfssl /ext-bin

# release image
FROM alpine:3.16
ENV CFSSL_VER=v1.6.3

COPY --from=builder_120 /ext-bin/* /bin
