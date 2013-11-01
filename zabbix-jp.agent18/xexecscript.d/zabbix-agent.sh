#!/bin/bash
#
# requires:
#  bash
#
set -e

chroot $1 $SHELL -ex <<EOS
  [[ -n "${zabbix_version}" ]] && {
    zabbix_version="-${zabbix_version}"
  }

  yum install -y zabbix-agent${zabbix_version}
EOS
