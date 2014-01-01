#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  rpm -ivh https://dl.bintray.com/mitchellh/vagrant/vagrant_1.4.2_$(arch).rpm
EOS
