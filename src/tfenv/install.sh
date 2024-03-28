#!/bin/bash
set -e

su -l $_REMOTE_USER -c "git clone --depth=1 https://github.com/tfutils/tfenv.git $_REMOTE_USER_HOME/.tfenv"
su -l $_REMOTE_USER -c "$_REMOTE_USER_HOME/.tfenv/bin/tfenv install"
su -l $_REMOTE_USER -c "$_REMOTE_USER_HOME/.tfenv/bin/tfenv use"
echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> $_REMOTE_USER_HOME/.bashrc
chown $_REMOTE_USER:$_REMOTE_USER -R $_REMOTE_USER_HOME

