#!/bin/bash
set -e

curl -L -o /usr/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_$(dpkg-architecture -q DEB_BUILD_ARCH)
chmod 755 /usr/bin/yq
