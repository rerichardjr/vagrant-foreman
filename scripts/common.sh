#!/bin/bash

set -euxo pipefail

files_folder="/vagrant/files"
password_file="/vagrant/files/password.txt"
hosts_file="/etc/hosts"
regex_ip="^127\.0\.[0-9]+\.[0-9]+"

commentLoopback() {
  if grep -q -E "${regex_ip} ${SERVER_HOSTNAME} ${SERVER_HOSTNAME}" "$hosts_file"; then
    sed -i -E "s/^${regex_ip} ${SERVER_HOSTNAME} ${SERVER_HOSTNAME}/#&/" "$hosts_file"
  else
    echo "Pattern not found in $hosts_file"
  fi
}

updateHostsFile() {
  if ! grep -q "${SERVER_IP}" "$hosts_file"; then
    echo "${SERVER_IP} ${SERVER_HOSTNAME}.${DOMAIN} ${SERVER_HOSTNAME}" >> $hosts_file
    echo "Added ${SERVER_IP} ${SERVER_HOSTNAME}.${DOMAIN} ${SERVER_HOSTNAME} to $hosts_file"
  fi
}

createFilesFolder() {
  if [ ! -d $files_folder ]; then
    echo "Creating $files_folder"
    mkdir $files_folder
  else
    echo "Folder $files_folder already exists"
  fi
}

createSupportUser() {
  if ! id ${SUPPORT_USER} >/dev/null 2>&1; then
    useradd ${SUPPORT_USER} -G sudo -m -s /bin/bash
    echo "User ${SUPPORT_USER} created."
  fi

  createFilesFolder

  if [ ! -f $password_file ]; then
    random_pw=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 8; echo)
    echo $random_pw > $password_file
    echo "Password for ${SUPPORT_USER} saved to $password_file"
  fi

  random_pw=$(cat $password_file)
  echo "$SUPPORT_USER:$random_pw" | chpasswd
}

commentLoopback
updateHostsFile
createSupportUser
