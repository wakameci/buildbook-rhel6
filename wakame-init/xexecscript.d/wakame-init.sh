#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  until curl -fsSkL -o /etc/yum.repos.d/wakame-vdc.repo https://raw.githubusercontent.com/axsh/wakame-vdc/master/rpmbuild/wakame-vdc.repo; do
    sleep 1
  done
  yum install --disablerepo=updates -y wakame-init
EOS
