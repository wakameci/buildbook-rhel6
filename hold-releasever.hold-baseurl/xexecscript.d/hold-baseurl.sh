#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

releasever=$(< ${chroot_dir}/etc/yum/vars/releasever)
majorver=${releasever%%.*}

mv ${chroot_dir}/etc/yum.repos.d/CentOS-Base.repo ${chroot_dir}/etc/yum.repos.d/CentOS-Base.repo.saved

cat <<-REPO > ${chroot_dir}/etc/yum.repos.d/CentOS-Base.repo
	[base]
	name=CentOS-\$releasever - Base
	baseurl=http://ftp.riken.jp/Linux/centos/\$releasever/os/\$basearch/
	gpgcheck=1
	gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${majorver}

	[updates]
	name=CentOS-\$releasever - Updates
	baseurl=http://ftp.riken.jp/Linux/centos/\$releasever/updates/\$basearch/
	gpgcheck=1
	gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${majorver}
	REPO
