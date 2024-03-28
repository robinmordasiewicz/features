#!/bin/bash
#

if [ -d /tmp/text-generation-webui ]; then
  cd /tmp/text-generation-webui && git pull
else
  git clone https://github.com/oobabooga/text-generation-webui.git /tmp/text-generation-webui
fi

source /opt/conda/etc/profile.d/conda.sh
conda activate textgen
cd /tmp/text-generation-webui
conda install -y -c "nvidia/label/cuda-12.1.1" cuda-runtime
pip install -r requirements.txt
python server.py
