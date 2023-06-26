FROM --platform=$BUILDPLATFORM debian:bookworm-slim

ARG TARGETPLATFORM
ARG DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.utf8
RUN apt-get update && \
    apt-get install -y locales && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
    apt-get install --no-install-recommends -y \
    meson gcc clang pkg-config \
    libjson-c-dev libssl-dev libdbus-1-dev libkeyutils-dev \
    ca-certificates git make libpam-dev libcap-ng-dev libpkgconf-dev libcurl4-openssl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
