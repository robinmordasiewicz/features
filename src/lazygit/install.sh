#!/bin/bash
set -e

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
ARCHTYPE=$(dpkg-architecture -q DEB_BUILD_ARCH)

if [[ "${ARCHTYPE}" == "amd64" ]]; then
	ARCHTYPE="x86_64"
fi

curl -L -o lazygit.tar.gz https://github.com/jesseduffield/lazygit/releases/download/v"${LAZYGIT_VERSION}"/lazygit_"${LAZYGIT_VERSION}"_Linux_${ARCHTYPE}.tar.gz
tar xf lazygit.tar.gz lazygit
rm lazygit.tar.gz
install lazygit /usr/local/bin
rm lazygit

