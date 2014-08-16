#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  chkconfig ntpd    on
  chkconfig ntpdate on
EOS
