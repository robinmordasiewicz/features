#!/bin/bash
set -e

WORKINGDIR=$(pwd)
su -l $_REMOTE_USER -c "source /opt/conda/etc/profile.d/conda.sh && /opt/conda/bin/conda env create -f ${WORKINGDIR}/environment.yml"

su -l $_REMOTE_USER -c "mkdir $_REMOTE_USER_HOME/.memgpt"
su -l $_REMOTE_USER -c "cp -a ${WORKINGDIR}/memgpt.conf $_REMOTE_USER_HOME/.memgpt/config"
su -l $_REMOTE_USER -c "cp -a ${WORKINGDIR}/initmemgpt.sql /tmp"

#sudo -H env PATH=$PATH git clone https://github.com/cpacker/MemGPT.git /tmp/MemGPT
#cd /tmp/MemGPT
#sudo -H env PATH=$PATH pip3 install --root-user-action=ignore -e .

#git clone --recursive https://github.com/pytorch/pytorch /tmp/torch
#cd /tmp/torch
#sudo -H env PATH=$PATH git submodule sync
#sudo -H env PATH=$PATH git submodule update --init --recursive
#export _GLIBCXX_USE_CXX11_ABI=1
#sudo -H env PATH=$PATH python setup.py develop
