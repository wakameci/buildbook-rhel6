#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

# jenkins:x:498:497:Jenkins Continuous Build server:/var/lib/jenkins:/bin/bash
# jenkins:x:497

chroot $1 $SHELL -ex <<'EOS'
  getent group  jenkins >/dev/null || groupadd -r jenkins
  getent passwd jenkins >/dev/null || useradd -g jenkins -d /var/lib/jenkins -s /bin/bash -r -m jenkins
  usermod -s /bin/bash jenkins

  getent group  jenkins
  getent passwd jenkins
EOS

configure_sudo_sudoers $1 jenkins NOPASSWD:
