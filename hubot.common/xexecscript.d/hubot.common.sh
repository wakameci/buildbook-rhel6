#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  npm install -g coffee-script hubot
  npm install -g yo generator-hubot
EOS
