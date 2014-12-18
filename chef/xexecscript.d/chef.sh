#!/bin/bash
#
# requires:
#  bash
#
# package:
#  http://www.opscode.com/chef/install/
#
set -e
set -o pipefail

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  install_script_path=/tmp/install.sh
  until curl -fsSkL -o ${install_script_path} https://www.opscode.com/chef/install.sh; do
    sleep 1
  done
  bash  ${install_script_path}
  rm -f ${install_script_path}
EOS
