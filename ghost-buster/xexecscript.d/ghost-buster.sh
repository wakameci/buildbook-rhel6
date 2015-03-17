#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  releasever=$(< /etc/yum/vars/releasever)

  arch=$(arch)
  case "${arch}" in
    i*86)   basearch=i386 arch=i686 ;;
    x86_64) basearch=${arch} ;;
  esac

  case "${releasever}" in
    6.6)
      yum install -y \
        glibc \
        glibc-common \
        glibc-devel \
        glibc-headers

      yum update  -y \
        glibc \
        glibc-common \
        glibc-devel \
        glibc-headers
      ;;
    6.[0-5])
      expected_version=2.12-1.149.el6_6.5

      case "$(rpm -qa --qf '%{Version}-%{Release}\n' glibc)" in
        ${expected_version})
          ;;
        *)
          base_uri=http://ftp.jaist.ac.jp/pub/Linux/CentOS/6.6/updates/${basearch}/Packages

          yum install -y \
            ${base_uri}/glibc-${expected_version}.${arch}.rpm \
            ${base_uri}/glibc-common-${expected_version}.${arch}.rpm \
            ${base_uri}/glibc-devel-${expected_version}.${arch}.rpm \
            ${base_uri}/glibc-headers-${expected_version}.${arch}.rpm
          ;;
      esac

      ;;
  esac
EOS
