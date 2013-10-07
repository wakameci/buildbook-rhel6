#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

chroot $1 $SHELL -ex <<'EOS'
  curl -fSkL   http://download.openvz.org/openvz.repo -o /etc/yum.repos.d/openvz.repo
  rpm --import http://download.openvz.org/RPM-GPG-Key-OpenVZ

  yum install -y vzkernel vzquota vzctl ploop

  pkg_name=vzkernel
  root_dev=$(awk '$2 == "/" {print $1}' /etc/fstab)

  rpm -qi ${pkg_name} >/dev/null || { echo "not available: ${pkg_name}" >&2; exit 1; }

  kernel_version=$(rpm -qi ${pkg_name} | egrep ^Version | awk '{print $3}')
  kernel_release=$(rpm -qi ${pkg_name} | egrep ^Release | awk '{print $3}')
  grub_title="OpenVZ (${kernel_version}-${kernel_release})"
  grub_title_regex="OpenVZ \(${kernel_version}-${kernel_release}\)"

  # /tmp/edit-grub4vz.sh add
  cat <<-_EOS_ >> /boot/grub/grub.conf
	title ${grub_title}
	        root (hd0,0)
	        kernel /boot/vmlinuz-${kernel_version}-${kernel_release} ro root=${root_dev} rd_NO_LUKS rd_NO_LVM LANG=en_US.UTF-8 rd_NO_MD SYSFONT=latarcyrheb-sun16 crashkernel=auto  KEYBOARDTYPE=pc KEYTABLE=us rd_NO_DM
	        initrd /boot/initramfs-${kernel_version}-${kernel_release}.img
	_EOS_

  # /tmp/edit-grub4vz.sh enable
  menu_order=$(egrep ^title /boot/grub/grub.conf | cat -n | grep "${grub_title}" | tail | awk '{print $1}')
  if [ -z "${menu_order}" ]; then
    menu_offset=0
  else
    menu_offset=$((${menu_order} - 1))
  fi
  sed -i "s,^default=.*,default=${menu_offset}," /boot/grub/grub.conf
EOS
