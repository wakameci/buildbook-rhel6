#!/bin/bash
#
# requires:
#  bash
#
set -e

chroot $1 $SHELL -ex <<EOS
  rpm -Uvh http://repo.zabbix.jp/relatedpkgs/rhel6/${basearch}/zabbix-jp-release-6-6.noarch.rpm
EOS
