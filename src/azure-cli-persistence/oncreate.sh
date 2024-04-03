#!/usr/bin/env bash

set -e

# if the user is not root, chown /dc/azure-cli to the user
if [ "$(id -u)" != "0" ]; then
  echo "Running oncreate.sh for user ${USER}"
  sudo chown -R "${USER}:${USER}" /dc/azure-cli
fi

yes y | az config set auto-upgrade.enable=yes
yes y | az config set auto-upgrade.prompt=no

if command -v bicep &>/dev/null; then
  cmd_path=$(command -v bicep)
  if [ ! -d "${HOME}/.azure/bin" ]; then
    mkdir -p "${HOME}/.azure/bin"
  fi
  ln -sf "${cmd_path}" "${HOME}/.azure/bin/bicep"
fi
