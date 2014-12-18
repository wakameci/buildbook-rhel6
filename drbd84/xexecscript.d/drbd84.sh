#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  yum search drbd
  yum install --disablerepo=updates -y drbd84-utils kmod-drbd84
EOS
