#!/usr/bin/env bash
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# Clean up
rm -rf /var/lib/apt/lists/*

apt_get_update()
{
    if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
        echo "Running apt-get update..."
        apt-get update -y
    fi
}

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        apt_get_update
        apt-get -y install --no-install-recommends "$@"
    fi
}

export DEBIAN_FRONTEND=noninteractive

check_packages fontconfig

# Clean up
rm -rf /var/lib/apt/lists/*

#WORKINGDIR=$(pwd)
#DOWNLOADLOCATION=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | jq -r '.assets[] | select(.name=="Meslo.zip").browser_download_url')
#curl -L -o fonts.zip ${DOWNLOADLOCATION}
#if [ ! -d /usr/share/fonts/NerdFonts ];then
#    mkdir -p /usr/share/fonts/NerdFonts
#fi

curl -s https://github.com/ryanoasis/nerd-fonts/blob/master/install.sh | bash -s -- --clean --install-to-system-path Meslo

#unzip ${WORKINGDIR}/fonts.zip -d /usr/share/fonts/NerdFonts"
#fc-cache /usr/share/fonts
