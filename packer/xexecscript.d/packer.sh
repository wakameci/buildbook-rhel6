#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  case $(arch) in
  i*86)   arch=386   ;;
  x86_64) arch=amd64 ;;
  esac

  until curl -fSkL -o /tmp/0.5.0_linux_${arch}.zip https://dl.bintray.com/mitchellh/packer/0.5.0_linux_${arch}.zip; do
    sleep 1
  done

  mkdir -p /usr/local/packer
  cd       /usr/local/packer

  yum install --disablerepo=updates -y unzip
  unzip /tmp/0.5.0_linux_${arch}.zip

  ls -l    /usr/local/packer
EOS
