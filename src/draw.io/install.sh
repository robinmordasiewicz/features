#!/bin/bash
set -e

ARCH=$(dpkg-architecture -q DEB_BUILD_ARCH)
download_url=$(curl --silent "https://api.github.com/repos/jgraph/drawio-desktop/releases/latest" | jq -r --arg ARCH "$ARCH" '.assets[] | select(.name | contains("deb") and contains($ARCH)) | .browser_download_url')
curl -s -L "${download_url}" -o "drawio.deb"
sudo dpkg -i drawio.deb
rm drawio.deb
