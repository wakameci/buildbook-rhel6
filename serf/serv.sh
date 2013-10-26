#!/bin/bash
#
# requires:
#  bash
#
# links:
#  https://github.com/hashicorp/serf/blob/master/demo/web-load-balancer/setup_serf.sh
#
set -e

declare chroot_dir=$1

run_yum ${chroot_dir} install wget unzip

chroot $1 $SHELL <<'EOS'
  # Download and install Serf
  cd /tmp
  until wget -O serf.zip https://dl.bintray.com/mitchellh/serf/0.1.1_linux_amd64.zip; do
    sleep 1
  done
  unzip serf.zip
  mv serf /usr/local/bin/serf
EOS
