#!/bin/bash
#
# requires:
#  bash
#
set -e

chroot $1 $SHELL -ex <<'EOS'
  yum install --disablerepo=updates --enablerepo=epel-testing -y s3cmd
EOS
