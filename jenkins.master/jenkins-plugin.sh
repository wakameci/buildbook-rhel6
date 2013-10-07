#!/bin/bash
#
# requires:
#  bash
#
set -e

chroot $1 $SHELL -ex <<'EOS'
  [[ -d /var/lib/jenkins/plugins ]] || mkdir -p /var/lib/jenkins/plugins
  # install git plugin
  base_url=http://updates.jenkins-ci.org/latest
  while read plugin; do
    curl -fSkL ${base_url}/${plugin}.hpi -o /var/lib/jenkins/plugins/${plugin}.hpi
  done < <(cat <<-_EOS_ | egrep -v '^#'
	build-pipeline-plugin
	categorized-view
	config-autorefresh-plugin
	configurationslicing
	config-file-provider
	compact-columns
	console-column-plugin
	cron_column
	dashboard-view
	depgraph-view
	downstream-buildview
	embeddable-build-status
	git
	git-client
	github-api
	github-oauth
	global-variable-string-parameter
	hipchat
	greenballs
	jobgenerator
	join
	managed-scripts
	nested-view
	next-executions
	parameterized-trigger
	rbenv
	rebuild
	simple-theme-plugin
	sounds
	timestamper
	token-macro
	urltrigger
	view-job-filters
	_EOS_
	)

  chown -R jenkins:jenkins /var/lib/jenkins/plugins
EOS
