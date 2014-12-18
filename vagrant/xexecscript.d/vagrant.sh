#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  # don't use 1.4.2. https://groups.google.com/forum/#!topic/vagrant-up/HNXKTBv0-Jw
  rpm -ivh https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3_$(arch).rpm
EOS
