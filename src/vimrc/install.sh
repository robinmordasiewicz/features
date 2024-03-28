#!/bin/bash
set -e

su -l $_REMOTE_USER -c "mkdir -p $_REMOTE_USER_HOME/.vim/pack/plugin/start"
su -l $_REMOTE_USER -c "git clone https://github.com/vim-airline/vim-airline $_REMOTE_USER_HOME/.vim/pack/plugin/start/vim-airline"
su -l $_REMOTE_USER -c "git clone https://github.com/hashivim/vim-terraform.git $_REMOTE_USER_HOME/.vim/pack/plugin/start/vim-terraform"
su -l $_REMOTE_USER -c "mkdir -p $_REMOTE_USER_HOME/.vim/pack/themes/start"
su -l $_REMOTE_USER -c "git clone https://github.com/tomasiser/vim-code-dark $_REMOTE_USER_HOME/.vim/pack/themes/start/vim-code-dark"
su -l $_REMOTE_USER -c "curl -L -o $_REMOTE_USER_HOME/.vimrc https://raw.githubusercontent.com/robinmordasiewicz/dotfiles/main/.vimrc"
