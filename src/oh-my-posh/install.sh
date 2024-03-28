#!/bin/bash
set -e

if [ ! -d /usr/local/share/oh-my-posh ];then
  mkdir -p /usr/local/share/oh-my-posh
fi

curl -s https://ohmyposh.dev/install.sh | bash -s -- -d /usr/local/bin -t /usr/local/share/oh-my-posh
curl -L -o /usr/local/share/oh-my-posh/powerlevel10k.omp.json https://raw.githubusercontent.com/robinmordasiewicz/dotfiles/main/powerlevel10k.omp.json

