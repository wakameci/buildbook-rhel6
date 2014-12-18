#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

chroot $1 $SHELL -ex <<EOS
  [[ -n "${zabbix_version}" ]] && {
    zabbix_version="-${zabbix_version}"
  }

  yum install --disablerepo=updates -y zabbix-web${zabbix_version}
EOS
