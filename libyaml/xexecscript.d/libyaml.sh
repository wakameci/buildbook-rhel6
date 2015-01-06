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

  arch=$(arch)
  case "${arch}" in
    i*86)   basearch=i386 arch=i686 ;;
    x86_64) basearch=${arch} ;;
  esac

  case "${releasever}" in
    6.[0-5])
      for pkg_name in libyaml libyaml-devel; do
        rpm -qa ${pkg_name} | egrep -q ${pkg_name} || {
          yum install -y http://ftp.jaist.ac.jp/pub/Linux/CentOS/6.6/os/${basearch}/Packages/${pkg_name}-0.1.3-1.4.el6.${arch}.rpm
        }
      done
      ;;
    *)
      yum install --disablerepo=updates -y libyaml libyaml-devel
      ;;
  esac
EOS
