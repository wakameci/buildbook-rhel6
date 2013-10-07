#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

chroot $1 $SHELL -ex <<EOS
  curl -fSkL   http://download.openvz.org/openvz.repo -o /etc/yum.repos.d/openvz.repo
  rpm --import http://download.openvz.org/RPM-GPG-Key-OpenVZ

  yum install -y vzkernel vzquota vzctl ploop
EOS
