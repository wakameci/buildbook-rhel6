#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

declare abs_dirname=${BASH_SOURCE[0]%/*}/
declare name=$1
declare chroot_dir=${2:-/}

if [[ -z "${name}" ]]; then
  cat <<-EOS >&2
	USAGE
	  $ run-book.sh <name> <chroot-dir>
	EOS
  exit 1
fi

cd ${abs_dirname}

[[ -d ${name} ]]

# TODO: support copy.txt deployment.

xexecscript="$(find -L ${name} ! -type d -perm -a=x | sort)"

while read line; do
  echo eval ${line} ${chroot_dir}
done <<< "${xexecscript}"
