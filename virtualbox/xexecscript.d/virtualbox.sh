#!/bin/bash
#
# requires:
#  bash
#
set -e

# use vmbuilder function
configure_virtualbox $1

chroot $1 $SHELL -ex <<'EOS'
  yum install -y make kernel-devel gcc perl
EOS
