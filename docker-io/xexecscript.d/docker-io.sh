#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  yum install --disablerepo=updates -y docker-io
EOS

# install_menu_lst_kernel_ml_aufs $1
chroot $1 $SHELL -ex <<'EOS'
  version=$(rpm -q --qf '%{Version}-%{Release}' kernel-ml-aufs)
  [[ -n "${version}" ]] || { echo "[ERROR] kernel-ml-aufs not found (${BASH_SOURCE[0]##*/}:${LINENO})" &2; return 1; }

  bootdir_path=
  root_dev=$(awk '$2 == "/boot" {print $1}' /etc/fstab)

  [[ -n "${root_dev}" ]] || {
    # has no /boot partition case
    root_dev=$(awk '$2 == "/" {print $1}' /etc/fstab)
    bootdir_path=/boot
  }

  grub_title="kernel-ml-aufs (${version})"
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
  [[ -z "${menu_order}" ]] || {
    menu_offset=$((${menu_order} - 1))
  }
  sed -i "s,^default=.*,default=${menu_offset}," /boot/grub/grub.conf
  cat /boot/grub/grub.conf
EOS

chroot $1 $SHELL -ex <<'EOS'
  echo "none                    /sys/fs/cgroup          cgroup  defaults        0 0" >> /etc/fstab
EOS
