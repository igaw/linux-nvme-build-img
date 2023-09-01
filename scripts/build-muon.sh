#!/bin/bash

BUILDDIR="$(pwd)/.build"

tools_build_samurai() {
    mkdir -p "${BUILDDIR}"/build-tools
    git clone --depth 1 https://github.com/michaelforney/samurai.git \
        "${BUILDDIR}/build-tools/samurai"
    pushd "${BUILDDIR}/build-tools/samurai" || exit 1

    CC="${CC}" make
    SAMU="${BUILDDIR}/build-tools/samurai/samu"

    popd || exit 1
}

tools_build_muon() {
    mkdir -p "${BUILDDIR}"/build-tools
    git clone --depth 1 https://git.sr.ht/~lattis/muon \
        "${BUILDDIR}/build-tools/muon"
    pushd "${BUILDDIR}/build-tools/muon" || exit 1

    CC="${CC}" ninja="${SAMU}" ./bootstrap.sh stage1

    CC="${CC}" ninja="${SAMU}" stage1/muon setup        \
        -Dprefix="${BUILDDIR}/build-tools"              \
        -Dlibcurl=enabled                               \
        -Dlibarchive=enabled                            \
        -Dlibpkgconf=enabled                            \
        -Ddocs=disabled                                 \
        -Dsamurai=disabled                              \
        "${BUILDDIR}/build-tools/.build-muon"
    "${SAMU}" -C "${BUILDDIR}/build-tools/.build-muon"
    MUON="${BUILDDIR}/build-tools/.build-muon/muon"

    "${MUON}" -C "${BUILDDIR}/build-tools/.build-muon" test

    popd || exit 1
}

tools_build_samurai
tools_build_muon

cp "${SAMU}" .
cp "${MUON}" .
