#!/bin/bash

set -e

# Checks if packages are installed and installs them if not
check_packages() {
  if ! dpkg -s "$@" >/dev/null 2>&1; then
    apt-get update -y
    apt-get -y install --no-install-recommends "$@"
  fi
}

export DEBIAN_FRONTEND=noninteractive

check_packages fontconfig fonts-powerline

fc-cache -f /usr/share/fonts

# Clean up
rm -rf /var/lib/apt/lists/*

su -l "${_REMOTE_USER}" -c "mkdir -p ${_REMOTE_USER_HOME}/.vim/pack/plugin/start"
su -l "${_REMOTE_USER}" -c "git clone https://github.com/vim-airline/vim-airline ${_REMOTE_USER_HOME}/.vim/pack/plugin/start/vim-airline"
su -l "${_REMOTE_USER}" -c "git clone https://github.com/hashivim/vim-terraform.git ${_REMOTE_USER_HOME}/.vim/pack/plugin/start/vim-terraform"
su -l "${_REMOTE_USER}" -c "mkdir -p ${_REMOTE_USER_HOME}/.vim/pack/themes/start"
su -l "${_REMOTE_USER}" -c "git clone https://github.com/tomasiser/vim-code-dark ${_REMOTE_USER_HOME}/.vim/pack/themes/start/vim-code-dark"
su -l "${_REMOTE_USER}" -c "curl -L -o ${_REMOTE_USER_HOME}/.vimrc https://raw.githubusercontent.com/robinmordasiewicz/dotfiles/main/.vimrc"
