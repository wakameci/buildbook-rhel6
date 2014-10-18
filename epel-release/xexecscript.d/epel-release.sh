#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  rpm -qi epel-release-6-8 >/dev/null || {
    yum install --disablerepo=updates -y http://ftp.riken.jp/Linux/fedora/epel/6/i386/epel-release-6-8.noarch.rpm

    # in order escape below error
    # > Error: Cannot retrieve metalink for repository: epel. Please verify its path and try again
    yum install -y ca-certificates
  }
EOS
