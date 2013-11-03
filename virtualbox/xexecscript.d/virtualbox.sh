#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  yum install --disablerepo=updates -y install make kernel-devel gcc perl
  yum install --disablerepo=updates -y install VirtualBox-4.2
EOS
