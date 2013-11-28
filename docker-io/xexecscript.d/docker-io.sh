#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

function kernel_ml_aufs_version() {
  local chroot_dir=$1
  [[ -d "${chroot_dir}" ]] || { echo "[ERROR] directory not found: ${chroot_dir} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }

  chroot ${chroot_dir} rpm -q --qf '%{Version}-%{Release}' kernel-ml-aufs
}

function install_menu_lst_kernel_ml_aufs() {
  local chroot_dir=$1
  [[ -d "${chroot_dir}"                     ]] || { echo "[ERROR] directory not found: ${chroot_dir} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }
  [[ -a "${chroot_dir}/etc/fstab"           ]] || { echo "[WARN] file not found: ${chroot_dir}/etc/fstab (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 0; }
  [[ -a "${chroot_dir}/boot/grub/grub.conf" ]] || { echo "[ERROR] file not found: ${chroot_dir}/boot/grub/grub.conf (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }
  local version=$(kernel_ml_aufs_version ${chroot_dir})
  [[ -n "${version}" ]] || { echo "[ERROR] kernel-ml-aufs not found (${BASH_SOURCE[0]##*/}:${LINENO})" &2; return 1; }

  local bootdir_path=
  local root_dev=$(awk '$2 == "/boot" {print $1}' ${chroot_dir}/etc/fstab)

  [[ -n "${root_dev}" ]] || {
    # has no /boot partition case
    root_dev=$(awk '$2 == "/" {print $1}' ${chroot_dir}/etc/fstab)
    bootdir_path=/boot
  }

  local grub_title="kernel-ml-aufs (${version})"
  cat <<-_EOS_ >> ${chroot_dir}/boot/grub/grub.conf
	title ${grub_title}
	        root (hd0,0)
	        kernel ${bootdir_path}/vmlinuz-${version}.${basearch} ro root=${root_dev} rd_NO_LUKS rd_NO_LVM LANG=en_US.UTF-8 rd_NO_MD SYSFONT=latarcyrheb-sun16 crashkernel=auto KEYBOARDTYPE=pc KEYTABLE=us rd_NO_DM selinux=${selinux:-0}
	        initrd ${bootdir_path}/initramfs-${version}.${basearch}.img
	_EOS_

  # set default kernel
  # *** "grep" should be used at after 'cat -n'. because ${grub_title} includes regex meta characters. ex. '(' and ')'. ***
  local menu_order=$(egrep ^title ${chroot_dir}/boot/grub/grub.conf | cat -n | grep "${grub_title}" | tail | awk '{print $1}')
  local menu_offset=0
  [[ -z "${menu_order}" ]] || {
    menu_offset=$((${menu_order} - 1))
  }
  sed -i "s,^default=.*,default=${menu_offset}," ${chroot_dir}/boot/grub/grub.conf
  cat ${chroot_dir}/boot/grub/grub.conf
}

chroot $1 $SHELL -ex <<'EOS'
  yum install --disablerepo=updates -y docker-io
EOS

install_menu_lst_kernel_ml_aufs $1

chroot $1 $SHELL -ex <<'EOS'
  echo "none                    /sys/fs/cgroup          cgroup  defaults        0 0" >> /etc/fstab
EOS
