#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  yum install --disablerepo=updates -y bridge-utils

  until curl -fsSkL -o /usr/local/bin/pipework https://raw.github.com/hansode/pipework/for-centos6/pipework; do
    sleep 1
  done
  chmod +x /usr/local/bin/pipework
  ln -s /usr/local/bin/pipework /usr/bin/pipework
EOS
