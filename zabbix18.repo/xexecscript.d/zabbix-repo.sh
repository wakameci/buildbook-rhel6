#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

chroot $1 $SHELL -ex <<EOS
  rpm -Uvh http://repo.zabbix.com/zabbix/1.8/rhel/6/${basearch}/zabbix-release-1.8-1.el6.noarch.rpm
EOS
