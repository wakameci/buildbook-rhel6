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
    6.6)
      yum update  -y glibc ;;
    6.[0-5])
      yum install -y \
        http://ftp.jaist.ac.jp/pub/Linux/CentOS/6.6/updates/${basearch}/Packages/glibc-2.12-1.149.el6_6.5.${arch}.rpm \
        http://ftp.jaist.ac.jp/pub/Linux/CentOS/6.6/updates/${basearch}/Packages/glibc-common-2.12-1.149.el6_6.5.${arch}.rpm \
        http://ftp.jaist.ac.jp/pub/Linux/CentOS/6.6/updates/${basearch}/Packages/glibc-devel-2.12-1.149.el6_6.5.${arch}.rpm \
        http://ftp.jaist.ac.jp/pub/Linux/CentOS/6.6/updates/${basearch}/Packages/glibc-headers-2.12-1.149.el6_6.5.${arch}.rpm
      ;;
  esac
EOS
