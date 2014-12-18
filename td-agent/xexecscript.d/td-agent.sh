#!/bin/bash
#
# requires:
#  bash
#
# Installing Fluentd Using rpm Package
# - http://docs.fluentd.org/articles/install-by-rpm
#
set -e
set -o pipefail

# make sure to define td-agent version
case "${td_agent_version}" in
""|latest)
   td_agent_version=
   ;;
*)
   td_agent_version="-${td_agent_version}"
   ;;
esac

chroot $1 $SHELL -ex <<EOS
  yum repolist
  yum install --disablerepo=updates -y td-agent${td_agent_version}
EOS
