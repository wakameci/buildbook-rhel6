#!/bin/bash
#
# requires:
#  bash
#
set -e

declare abs_dirname=${BASH_SOURCE[0]%/*}/
declare name=$1

[[ -n ${name} ]] || {
  echo "$ add-book.sh <name>" >&2
  exit 1
}


[[ -d ${name} ]] || mkdir ${name}
cd ${name}

: > copy.txt

for i in guestroot xexecscript.d; do
 [[ -d ${i} ]] || mkdir ${i}
done

echo "generated => ${name}"
