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

IFS=',' read -ra FONTS_ARRAY <<<"$FONTS"

for FONT in "${FONTS_ARRAY[@]}"; do
  DOWNLOADLOCATION=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | jq -r --arg FONT "${FONT}.tar.xz" '.assets[] | select(.name==$FONT).browser_download_url')

  if [[ -n "$DOWNLOADLOCATION" ]]; then
    if [ ! -d "/usr/share/fonts/NerdFonts/$FONT" ]; then
      mkdir -p "/usr/share/fonts/NerdFonts/$FONT"
    fi
    curl -L "$DOWNLOADLOCATION" | tar -xJf - -C "/usr/share/fonts/NerdFonts/$FONT"
  fi
done

fc-cache /usr/share/fonts
