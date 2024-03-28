#!/bin/bash
set -e

LSD_VERSION=$(curl -s "https://api.github.com/repos/lsd-rs/lsd/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

curl -L -o /tmp/lsd.deb https://github.com/lsd-rs/lsd/releases/download/v"${LSD_VERSION}"/lsd_"${LSD_VERSION}"_"$(dpkg-architecture -q DEB_BUILD_ARCH)".deb
apt-get install /tmp/lsd.deb
rm -rf /tmp/lsd.deb

