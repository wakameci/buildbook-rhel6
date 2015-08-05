#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  yum install --disablerepo=updates -y easy-rsa
  cd /usr/share/easy-rsa/2.*
  sed -i 's/export KEY_NAME=EasyRSA/export KEY_NAME=server/g' vars
  sed -i 's/--interact//g' build-ca
  sed -i 's/--interact//g' build-key
  sed -i 's/--interact//g' build-key-server
EOS
