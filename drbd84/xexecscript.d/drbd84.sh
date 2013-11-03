#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  yum search drbd
  yum install --disablerepo=updates -y install drbd84-utils kmod-drbd84
EOS
