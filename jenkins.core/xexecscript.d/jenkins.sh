#!/bin/bash
#
# requires:
#  bash
#
set -e

chroot $1 $SHELL -ex <<'EOS'
  curl -fSkL http://pkg.jenkins-ci.org/redhat/jenkins.repo -o /etc/yum.repos.d/jenkins.repo
  rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key

  # *** don't install java-1.7.0-openjdk ***
  yum install -y java-1.6.0-openjdk
  yum install -y jenkins
  # in order to draw graphs/charts
  yum install -y dejavu-sans-fonts
EOS
