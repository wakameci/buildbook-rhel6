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
    6.5)
      yum update  -y bash ;;
    6.[0-4])
      yum install -y http://http://vault.centos.org/6.5/updates/${basearch}/Packages/bash-4.1.2-15.el6_5.2.${arch}.rpm ;;
  esac
EOS
