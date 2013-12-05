#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  rpm -qi rdo-release-havana >/dev/null || { yum install --disablerepo=updates -y http://rdo.fedorapeople.org/openstack/openstack-havana/rdo-release-havana.rpm; }
EOS
