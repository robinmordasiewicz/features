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

check_packages curl

# Clean up
rm -rf /var/lib/apt/lists/*

if [ ! -d /usr/local/share/oh-my-posh ]; then
  mkdir -p /usr/local/share/oh-my-posh
fi

curl -s https://ohmyposh.dev/install.sh | bash -s -- -d /usr/local/bin -t /usr/local/share/oh-my-posh
curl -L -o /usr/local/share/oh-my-posh/powerlevel10k.omp.json https://raw.githubusercontent.com/robinmordasiewicz/dotfiles/main/powerlevel10k.omp.json
