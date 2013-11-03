#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  rpm -ql elrepo-release >/dev/null || yum install -y http://elrepo.org/elrepo-release-6-5.el6.elrepo.noarch.rpm
  yum repolist --disablerepo='*' --enablerepo='elrepo'
EOS
