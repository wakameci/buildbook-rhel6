#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  releasever=$(< /etc/yum/vars/releasever)
  majorver=${releasever%%.*}

  openvswitch_version=2.3.1

  repourl=http://dlc.openvnet.axsh.jp/packages/rhel/openvswitch/${releasever}

  case "${releasever}" in
    6.7)
      ;;
    *)
      yum install --disablerepo=updates -y ${repourl}/kmod-openvswitch-${openvswitch_version}-1.el${majorver}.x86_64.rpm
      ;;
  esac

  yum install --disablerepo=updates -y ${repourl}/openvswitch-${openvswitch_version}-1.x86_64.rpm
EOS
