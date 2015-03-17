#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  rpm -qa epel-release* | egrep -q epel-release || {
    rpm -Uvh http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/6/i386/epel-release-6-8.noarch.rpm

    # workaround 2014/10/17
    #
    # in order escape below error
    # > Error: Cannot retrieve metalink for repository: epel. Please verify its path and try again
    #
    sed -i \
     -e 's,^#baseurl,baseurl,' \
     -e 's,^mirrorlist=,#mirrorlist=,' \
     -e 's,http://download.fedoraproject.org/pub/epel/,http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/,' \
     /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel-testing.repo

    # in order to escape below error
    # > Error: Cannot retrieve metalink for repository: epel. Please verify its path and try again
    yum install -y ca-certificates
  }
EOS
