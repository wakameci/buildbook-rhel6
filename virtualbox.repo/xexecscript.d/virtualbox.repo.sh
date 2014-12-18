#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  if ! [[ -f /etc/yum.repos.d/virtualbox.repo ]]; then
    curl -fsSkL http://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo -o /etc/yum.repos.d/virtualbox.repo
  fi
EOS
