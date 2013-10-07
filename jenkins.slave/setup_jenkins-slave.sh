#!/bin/bash
#
# requires:
#  bash
#
set -e

configure_sudo_sudoers $1 jenkins NOPASSWD:

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
