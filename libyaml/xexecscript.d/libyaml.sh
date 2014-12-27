#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  releasever=$(< /etc/yum/vars/releasever)

  case "${releasever}" in
    6.[0-5])
      for pkg_name in libyaml libyaml-devel; do
        rpm -qa ${pkg_name} | egrep -q ${pkg_name} || { yum install -y http://ftp.jaist.ac.jp/pub/Linux/CentOS/6.6/os/x86_64/Packages/${pkg_name}-0.1.3-1.4.el6.x86_64.rpm; }
      done
      ;;
    *)
      yum install --disablerepo=updates -y libyaml libyaml-devel
      ;;
  esac
EOS
