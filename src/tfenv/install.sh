#!/bin/bash
set -e

if [ ! -d "${_REMOTE_USER_HOME}/.tfenv" ]; then
  su -l "${_REMOTE_USER}" -c "git clone --depth=1 https://github.com/tfutils/tfenv.git ${_REMOTE_USER_HOME}/.tfenv"
else
  cd "${_REMOTE_USER_HOME}/.tfenv" && su -l "${_REMOTE_USER}" -c "git pull"
fi

su -l "${_REMOTE_USER}" -c "${_REMOTE_USER_HOME}/.tfenv/bin/tfenv install"
su -l "${_REMOTE_USER}" -c "${_REMOTE_USER_HOME}/.tfenv/bin/tfenv use"
