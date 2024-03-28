#!/bin/bash
set -e

echo "$_REMOTE_USER ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/$_REMOTE_USER

npm install -g npm@latest

apt update
apt-get -y upgrade
apt -y autoremove
