#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  yum update  --disablerepo=updates --enablerepo=openstack-havana -y iproute
EOS
