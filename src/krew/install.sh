#!/bin/bash
set -e

set -x; cd "$(mktemp -d)" &&
OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
KREW="krew-${OS}_${ARCH}" &&
curl -o /tmp/${KREW}.tar.gz -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
tar zxvf "/tmp/${KREW}.tar.gz" -C /tmp &&
su -l "${_REMOTE_USER}" -c "/tmp/${KREW} install krew" &&
rm /tmp/${KREW}.tar.gz &&
rm /tmp/${KREW}
