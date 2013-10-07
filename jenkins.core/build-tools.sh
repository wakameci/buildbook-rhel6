#!/bin/bash
#
# requires:
#  bash
#
set -e

chroot $1 $SHELL -ex <<'EOS'
  yum install -y \
    qemu-kvm qemu-img \
    parted kpartx \
    gcc gcc-c++ \
    rpm-build automake createrepo \
    openssl-devel zlib-devel
EOS
