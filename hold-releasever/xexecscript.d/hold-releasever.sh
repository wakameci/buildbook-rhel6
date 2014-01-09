#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

echo ${distro_ver} > ${chroot_dir}/etc/yum/vars/releasever
