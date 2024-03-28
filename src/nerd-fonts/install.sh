#!/bin/bash
set -e

WORKINGDIR=$(pwd)
DOWNLOADLOCATION=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | jq -r '.assets[] | select(.name=="Meslo.zip").browser_download_url')
curl -L -o fonts.zip ${DOWNLOADLOCATION}
su -l $_REMOTE_USER -c "mkdir -p $_REMOTE_USER_HOME/.local/share/fonts"
su -l $_REMOTE_USER -c "unzip ${WORKINGDIR}/fonts.zip -d $_REMOTE_USER_HOME/.local/share/fonts/"
su -l $_REMOTE_USER -c "fc-cache $_REMOTE_USER_HOME/.local/share/fonts"
