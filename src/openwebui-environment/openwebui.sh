#!/bin/bash
#

if [ -d /tmp/open-webui ]; then
  cd /tmp/open-webui && git pull
else
  git clone https://github.com/open-webui/open-webui.git /tmp/open-webui
fi

source /opt/conda/etc/profile.d/conda.sh
conda env create -f ./.devcontainer/openwebui.yml

conda activate openwebui

cd /tmp/open-webui/

# Copying required .env file
cp -RPp .env.example .env

# Building Frontend Using Node
npm i
npm run build

# Serving Frontend with the Backend
cd ./backend
pip install -r requirements.txt -U
bash start.sh
