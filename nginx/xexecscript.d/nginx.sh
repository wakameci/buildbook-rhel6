#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  if [[ -f /etc/centos-release ]]; then
    distro_name=centos
  else
    distro_name=rhel
  fi

  rpm -Uvh http://nginx.org/packages/${distro_name}/6/noarch/RPMS/nginx-release-${distro_name}-6-0.el6.ngx.noarch.rpm
  yum install --disablerepo=updates -y nginx
EOS
