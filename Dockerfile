FROM debian:bookworm-slim

ARG TARGETPLATFORM
ARG DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.utf8
RUN dpkg --add-architecture amd64 && \
    dpkg --add-architecture arm64 && \
    dpkg --add-architecture armhf && \
    dpkg --add-architecture s390x && \
    dpkg --add-architecture ppc64el && \
    apt-get update && \
    apt-get install -y locales && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
    apt-get install --no-install-recommends -y \
    meson gcc clang pkg-config \
    libjson-c-dev libssl-dev libdbus-1-dev libkeyutils-dev \
    ca-certificates git make libpam-dev libcap-ng-dev libpkgconf-dev libcurl4-openssl-dev libarchive-dev \
    qemu-user-static gcc-12-aarch64-linux-gnu gcc-12-arm-linux-gnueabi gcc-12-s390x-linux-gnu gcc-12-powerpc64le-linux-gnu \
    libjson-c-dev:amd64 libjson-c-dev:arm64 libjson-c-dev:armhf libjson-c-dev:s390x libjson-c-dev:ppc64el && \
    apt-get update && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
