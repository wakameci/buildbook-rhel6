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
    6.[0-5])
      expected_version=1.0.1e-16.el6_5.15

      case "$(rpm -qa --qf '%{Version}-%{Release}\n' openssl)" in
        ${expected_version})
          ;;
        *)
          base_uri=http://vault.centos.org/6.5/updates/${basearch}/Packages

          yum install -y \
            ${base_uri}/openssl-${expected_version}.${arch}.rpm
          ;;
      esac

      ;;
  esac
EOS
