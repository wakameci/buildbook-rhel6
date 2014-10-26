#!/bin/bash
#
# requires:
#  bash
#
set -e

# jenkins:x:498:497:Jenkins Continuous Build server:/var/lib/jenkins:/bin/bash
# jenkins:x:497

chroot $1 $SHELL -ex <<'EOS'
  getent group  jenkins >/dev/null || groupadd jenkins
  getent passwd jenkins >/dev/null || useradd -g jenkins -d /var/lib/jenkins -s /bin/bash -m jenkins
  usermod -s /bin/bash jenkins
EOS

configure_sudo_sudoers $1 jenkins NOPASSWD:

chroot $1 $SHELL -ex <<'EOS'
  chkconfig --list jenkins || {
    chkconfig jenkins off
    chkconfig --list jenkins
  }
EOS

chroot $1 su - jenkins <<'EOS'
  [ -d .ssh ] || mkdir -m 700 .ssh
  : >       /var/lib/jenkins/.ssh/authorized_keys
  chmod 644 /var/lib/jenkins/.ssh/authorized_keys
EOS
