#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  yum install --disablerepo=updates -y kernel-ml-aufs
EOS

chroot $1 $SHELL -ex <<'EOS'
  case "$(arch)" in
  i[3-6]86) basearch=i386   ;;
    x86_64) basearch=x86_64 ;;
  esac

  kernel_name=kernel-ml-aufs
  version=$(rpm -q --qf '%{Version}-%{Release}' ${kernel_name})

  bootdir_path=
  root_dev=$(awk '$2 == "/boot" {print $1}' /etc/fstab)

  if [[ -z "${root_dev}" ]]; then
    # has no /boot partition case
    root_dev=$(awk '$2 == "/" {print $1}' /etc/fstab)
    bootdir_path=/boot
  fi

  grub_title="${kernel_name} (${version})"
  cat <<-_EOS_ >> /boot/grub/grub.conf
	title ${grub_title}
	        root (hd0,0)
	        kernel ${bootdir_path}/vmlinuz-${version}.${basearch} ro root=${root_dev} rd_NO_LUKS rd_NO_LVM LANG=en_US.UTF-8 rd_NO_MD SYSFONT=latarcyrheb-sun16 crashkernel=auto KEYBOARDTYPE=pc KEYTABLE=us rd_NO_DM selinux=${selinux:-0}
	        initrd ${bootdir_path}/initramfs-${version}.${basearch}.img
	_EOS_

  # set default kernel
  # *** "grep" should be used at after 'cat -n'. because ${grub_title} includes regex meta characters. ex. '(' and ')'. ***
  menu_order=$(egrep ^title /boot/grub/grub.conf | cat -n | grep "${grub_title}" | tail | awk '{print $1}')
  menu_offset=0
  if [[ -n "${menu_order}" ]]; then
    menu_offset=$((${menu_order} - 1))
  fi
  sed -i "s,^default=.*,default=${menu_offset}," /boot/grub/grub.conf
  cat /boot/grub/grub.conf
EOS
