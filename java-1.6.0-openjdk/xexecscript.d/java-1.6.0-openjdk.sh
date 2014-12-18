#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  # *** don't install java-1.7.0-openjdk ***
  yum install --disablerepo=updates -y java-1.6.0-openjdk
EOS
