#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

run_yum ${chroot_dir} install haproxy
