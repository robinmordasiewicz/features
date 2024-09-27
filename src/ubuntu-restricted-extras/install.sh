#!/bin/bash
set -e

echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections
yes '' | add-apt-repository -y multiverse

DEBIAN_FRONTEND=noninteractive apt-get update &&
  DEBIAN_FRONTEND=noninteractive apt-get install -y ubuntu-restricted-extras &&
  apt-get clean && rm -rf /var/lib/apt/lists/*
