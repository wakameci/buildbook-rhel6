#!/bin/bash
#
# requires:
#  bash
#
set -e

run_yum ${chroot_dir} install git make sudo rpm-build rpmdevtools yum-utils tar
