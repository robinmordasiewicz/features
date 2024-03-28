#!/bin/bash
set -e

# shellcheck disable=SC2016
su -l $_REMOTE_USER -c "echo 'eval \"\$(oh-my-posh init zsh --config /usr/local/share/oh-my-posh/powerlevel10k.omp.json)\"' >> $_REMOTE_USER_HOME/.zshrc"
# shellcheck disable=SC2016
su -l $_REMOTE_USER -c "echo 'eval \"\$(oh-my-posh init bash --config /usr/local/share/oh-my-posh/powerlevel10k.omp.json)\"' >> $_REMOTE_USER_HOME/.bashrc"

if [ ! -d $_REMOTE_USER_HOME/.oh-my-zsh/custom ];then
  mkdir -p $_REMOTE_USER_HOME/.oh-my-zsh/custom && chown $_REMOTE_USER:$_REMOTE_USER $_REMOTE_USER_HOME/.oh-my-zsh/custom
fi

su -l $_REMOTE_USER -c "curl -L -o $_REMOTE_USER_HOME/.oh-my-zsh/custom/az.zsh https://raw.githubusercontent.com/Azure/azure-cli/dev/az.completion"

su -l $_REMOTE_USER -c "curl -L -o $_REMOTE_USER_HOME/.tmux.conf https://raw.githubusercontent.com/robinmordasiewicz/dotfiles/main/.tmux.conf"
su -l $_REMOTE_USER -c "mkdir -p $_REMOTE_USER_HOME/.tmux/plugins"
su -l $_REMOTE_USER -c "git clone https://github.com/tmux-plugins/tpm $_REMOTE_USER_HOME/.tmux/plugins/tpm"

if command -v /opt/conda/bin/conda &> /dev/null; then
  su -l $_REMOTE_USER -c "/opt/conda/bin/conda init --all"
  su -l $_REMOTE_USER -c "/opt/conda/bin/conda config --set changeps1 False"
fi
