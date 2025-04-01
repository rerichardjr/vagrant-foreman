#!/bin/bash

set -euxo pipefail

foreman_log="/var/log/foreman-installer/foreman.log"
foreman_user="foreman::params::oauth_effective_user:"
foreman_password="foreman::params::initial_admin_password:"
foreman_creds_file="/vagrant/files/foreman_creds.txt"
foreman_url="deb.theforeman.org"
foreman_sources_file="/etc/apt/sources.list.d/foreman.list"

installForeman() {
  sudo apt-get -y install ca-certificates
  cd /tmp && wget https://apt.puppet.com/puppet8-release-jammy.deb
  sudo apt-get install /tmp/puppet8-release-jammy.deb

  sudo wget https://$foreman_url/foreman.asc -O /etc/apt/trusted.gpg.d/foreman.asc
  echo "deb http://$foreman_url/ jammy ${FOREMAN_VERSION}" | sudo tee $foreman_sources_file
  echo "deb http://$foreman_url/ plugins ${FOREMAN_VERSION}" | sudo tee -a $foreman_sources_file

  sudo apt-get update && sudo apt-get -y install foreman-installer

  sudo foreman-installer
}

getForemanCreds() {
  log_entries=($foreman_user $foreman_password)
  creds=()

  if [ -f $foreman_log ]; then
    for log_entry in "${log_entries[@]}"; do
      creds+=($(grep $log_entry $foreman_log | awk '{print $2}'))
    done
  else
    echo "The log file $foreman_log doesn't exist"
  fi

  echo "${creds[@]}" > $foreman_creds_file
  echo "Saved foreman credentials to $foreman_creds_file"
}

installForeman
getForemanCreds