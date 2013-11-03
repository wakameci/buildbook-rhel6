#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  jre6_ver=1.6.0_38
  jre6_uri_32="http://javadl.sun.com/webapps/download/AutoDL?BundleId=71302"
  jre6_uri_64="http://javadl.sun.com/webapps/download/AutoDL?BundleId=71304"
  jre6_name=jre-6u-linux-rpm.bin
  jre6_path=/tmp/${jre6_name}

  case "$(arch)" in
    i*86) jre6_location=${jre6_uri_32} ;;
  x86_64) jre6_location=${jre6_uri_64} ;;
  esac

  yum install --disablerepo=updates -y which

  curl -fsSkL ${jre6_location} -o ${jre6_path}
  cd /tmp
  sh ${jre6_path}

  alternatives --install /usr/bin/java java /usr/java/jre${jre6_ver}/bin/java 20000
  java -version 2>&1
EOS
