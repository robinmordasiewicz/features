#!/bin/bash
set -e

LATEST_VERSION=$(curl -s "https://api.github.com/repos/cert-manager/cmctl/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
ARCHTYPE=$(dpkg-architecture -q DEB_BUILD_ARCH)

curl -L -o cmctl "https://github.com/cert-manager/cmctl/releases/download/v${LATEST_VERSION}/cmctl_linux_${ARCHTYPE}"
install cmctl /usr/local/bin
rm cmctl
