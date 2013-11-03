#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  yum install --disablerepo=updates -y kernel-devel
  yum localinstall -y --nogpgcheck http://archive.zfsonlinux.org/epel/zfs-release-1-2.el6.noarch.rpm
  yum install --disablerepo=updates -y zfs

  chkconfig --list zfs
  chkconfig --add  zfs
  chkconfig --list zfs
EOS
