#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  yum install --disablerepo=updates -y docker-io
EOS

chroot $1 $SHELL -ex <<'EOS'
  sed -i "s,^net.ipv4.ip_forward = 0,net.ipv4.ip_forward = 1," /etc/sysctl.conf
  echo "none                    /sys/fs/cgroup          cgroup  defaults        0 0" >> /etc/fstab
EOS
