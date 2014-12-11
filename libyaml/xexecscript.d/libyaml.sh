#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  releasever=$(< /etc/yum/vars/releasever)

  case "${releasever}" in
    6.[0-5])
      yum install -y http://ftp.jaist.ac.jp/pub/Linux/CentOS/6.6/os/x86_64/Packages/libyaml-0.1.3-1.4.el6.x86_64.rpm
      yum install -y http://ftp.jaist.ac.jp/pub/Linux/CentOS/6.6/os/x86_64/Packages/libyaml-devel-0.1.3-1.4.el6.x86_64.rpm
      ;;
    *)
      yum install --disablerepo=updates -y libyaml libyaml-devel
      ;;
  esac
EOS
