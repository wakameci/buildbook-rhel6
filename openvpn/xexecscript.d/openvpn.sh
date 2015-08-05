#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  yum install --disablerepo=updates -y openvpn
  cp /usr/share/doc/openvpn-*/sample/sample-config-files/server.conf /etc/openvpn
  sed -i 's/;push \"redirect-gateway def1 bypass-dhcp\"/push \"redirect-gateway def1 bypass-dhcp\"/g' /etc/openvpn/server.conf
  sed -i 's/;push \"dhcp-option/push \"dhcp option/g' /etc/openvpn/server.conf
  sed -i 's/;user nobody/user nobody/g' /etc/openvpn/server.conf
  sed -i 's/group nobody/group nobody/g' /etc/openvpn/server.conf
EOS
