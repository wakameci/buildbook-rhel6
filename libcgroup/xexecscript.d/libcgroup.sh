#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  yum install --disablerepo=updates -y libcgroup
EOS

chroot $1 $SHELL -ex <<'EOS'
  egrep ^cgroup /etc/fstab || { echo "cgroup /cgroup cgroup defaults 0 0" >> /etc/fstab; }
EOS
