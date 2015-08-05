#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  mkdir -p /etc/openvpn/easy-rsa/keys
  cp -rf /usr/share/easy-rsa/2.0/* /etc/openvpn/easy-rsa
  cp /etc/openvpn/easy-rsa/openssl-1.0.0.cnf /etc/openvpn/easy-rsa/openssl.cnf
  cd /etc/openvpn/easy-rsa
  source ./vars
  ./clean-all
  ./build-ca
  ./build-key-server server
  ./build-dh
  cd /etc/openvpn/easy-rsa/keys
  cp dh2048.pem ca.crt server.crt server.key /etc/openvpn
EOS
