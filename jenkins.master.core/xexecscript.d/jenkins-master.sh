#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  curl -fSkL http://pkg.jenkins-ci.org/redhat/jenkins.repo -o /etc/yum.repos.d/jenkins.repo
  rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key

  # *** don't install java-1.7.0-openjdk ***
  yum install --disablerepo=updates -y jenkins
  # in order to draw graphs/charts
  yum install --disablerepo=updates -y dejavu-sans-fonts

  # prevent jenkins starting
  chkconfig --list jenkins
  chkconfig jenkins off
  chkconfig --list jenkins
EOS
