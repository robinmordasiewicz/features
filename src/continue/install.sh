#!/bin/bash
set -e

check_packages() {
  if ! dpkg -s "$@" >/dev/null 2>&1; then
    apt-get update -y
    apt-get -y install --no-install-recommends "$@"
  fi
}

export DEBIAN_FRONTEND=noninteractive

check_packages curl

if [ ! -d "${_REMOTE_USER_HOME}/.continue" ]; then
  su -l "${_REMOTE_USER}" -c "mkdir -p ${_REMOTE_USER_HOME}/.continue"
fi

su -l "${_REMOTE_USER}" -c "curl -L https://raw.githubusercontent.com/robinmordasiewicz/dotfiles/main/.continue/config.json -o ${_REMOTE_USER_HOME}/.continue/config.json"
