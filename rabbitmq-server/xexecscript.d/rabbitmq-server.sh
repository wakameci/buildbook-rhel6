#!/bin/bash
#
# requires:
#  bash
#
# package:
#  http://www.rabbitmq.com/releases/rabbitmq-server/current/
#
set -e
set -o pipefail

declare chroot_dir=$1

rabbitmq_server_version=${rabbitmq_server_version:-3.2.1}

chroot $1 $SHELL -ex <<EOS
  yum install --disablerepo=updates -y http://www.rabbitmq.com/releases/rabbitmq-server/v${rabbitmq_server_version}/rabbitmq-server-${rabbitmq_server_version}-1.noarch.rpm
EOS
