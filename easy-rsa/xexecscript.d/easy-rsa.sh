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
  mkdir -p /etc/openvpn/easy-rsa/keys
  cp -rf /usr/share/easy-rsa/2.0/* /etc/openvpn/easy-rsa
  sed -i 's/export KEY_NAME=EasyRSA/export KEY_NAME=server/g' /etc/openvpn/easy-rsa/vars
  cp /etc/openvpn/easy-rsa/openssl-1.0.0.cnf /etc/openvpn/easy-rsa/openssl.cnf
  cd /etc/openvpn/easy-rsa
  source ./vars
  ./clean-all
  sed -i 's/--interactive//g' build-ca
  sed -i 's/--interactive//g' build-key
  sed -i 's/--interactive//g' build-key-server
  ./build-ca
  ./build-key-server server
  ./build-dh
  cd /etc/openvpn/easy-rsa/keys
  cp dh1024.pem ca.crt server.crt server.key /etc/openvpn
EOS
