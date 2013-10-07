#!/bin/bash
#
# requires:
#  bash
#

cat <<EOS > $1/etc/modprobe.d/disable-ipv6.conf
install ipv6 /bin/true
EOS

cat <<EOS >> $1/etc/sysconfig/network
NETWORKING_IPV6=no
IPV6INIT=no
EOS
