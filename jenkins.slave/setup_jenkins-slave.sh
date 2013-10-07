#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

configure_sudo_sudoers ${chroot_dir} jenkins NOPASSWD:

chroot $1 $SHELL -ex <<'EOS'
  usermod -s /bin/bash jenkins

  chkconfig --list jenkins
  chkconfig jenkins off
  chkconfig --list jenkins
EOS

chroot $1 su - jenkins <<'EOS'
  [ -d .ssh ] || mkdir -m 700 .ssh
  : >       /var/lib/jenkins/.ssh/authorized_keys
  chmod 644 /var/lib/jenkins/.ssh/authorized_keys
EOS
