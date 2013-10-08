#!/bin/bash
#
# requires:
#  bash
#
set -e

chroot $1 $SHELL -ex <<EOS
  yum install -y ntp ntpdate

  chkconfig ntpd    on
  chkconfig ntpdate on
EOS
