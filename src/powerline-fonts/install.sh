#!/usr/bin/env bash
set -e

if [ "$(id -u)" -ne 0 ]; then
  echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
  exit 1
fi

FONTS=${FONTS:-undefined}

# Checks if packages are installed and installs them if not
check_packages() {
  if ! dpkg -s "$@" >/dev/null 2>&1; then
    apt-get update -y
    apt-get -y install --no-install-recommends "$@"
  fi
}

export DEBIAN_FRONTEND=noninteractive

check_packages fontconfig

# Clean up
rm -rf /var/lib/apt/lists/*

if [ ! -d "/usr/share/fonts/powerline" ]; then
  mkdir -p "/usr/share/fonts/powerline"
fi

curl -L https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf -o /usr/share/fonts/powerline/PowerlineSymbols.otf

if [ ! -d /etc/fonts/conf.avail ]; then
  mkdir -p /etc/fonts/conf.avail
fi
curl -L https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf -o /etc/fonts/conf.avail/
#wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf

if which fc-cache >/dev/null 2>&1; then
  echo "Resetting font cache, this may take a moment..."
  fc-cache -f /usr/share/fonts
fi
