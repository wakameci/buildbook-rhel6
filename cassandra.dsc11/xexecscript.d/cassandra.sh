#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

declare chroot_dir=$1


chroot $1 $SHELL -ex <<EOS
  yum search dsc
  # dsc.noarch : Meta RPM for installation of the DataStax DSC platform
  # dsc1.1.noarch : Meta RPM for installation of the DataStax DSC platform
  # dsc12.noarch : Meta RPM for installation of the DataStax DSC platform
  # dsc20.noarch : Meta RPM for installation of the DataStax DSC platform

  [[ -n "${dsc_version}" ]] && {
    dsc_version="-${dsc_version}"
  }

  yum install --disablerepo=updates -y dsc1.1${dsc_version}

 #chkconfig cassandra on
 #chkconfig --list cassandra
EOS
