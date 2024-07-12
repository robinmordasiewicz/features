#!/bin/bash
set -e

check_packages() {
  if ! dpkg -s "$@" >/dev/null 2>&1; then
    apt-get update -y
    apt-get -y install --no-install-recommends "$@"
  fi
}

export DEBIAN_FRONTEND=noninteractive

check_packages locales locales-all

su -l "${_REMOTE_USER}" -c "echo '+nostats +nocomments +nocmd +noquestion +recurse +search' > ${_REMOTE_USER_HOME}/.digrc"

# shellcheck disable=SC2016
su -l "${_REMOTE_USER}" -c "echo 'eval \"\$(oh-my-posh init zsh --config /usr/local/share/oh-my-posh/powerlevel10k.omp.json)\"' >> ${_REMOTE_USER_HOME}/.zshrc"
# shellcheck disable=SC2016
su -l "${_REMOTE_USER}" -c "echo 'eval \"\$(oh-my-posh init bash --config /usr/local/share/oh-my-posh/powerlevel10k.omp.json)\"' >> ${_REMOTE_USER_HOME}/.bashrc"

su -l "${_REMOTE_USER}" -c "mkdir ~/.kube"

if command -v az &>/dev/null; then
  su -l "${_REMOTE_USER}" -c "yes y | az config set auto-upgrade.enable=yes"
  su -l "${_REMOTE_USER}" -c "yes y | az config set auto-upgrade.prompt=no"
  #su -l "${_REMOTE_USER}" -c "az provider register --namespace Microsoft.Kubernetes"
  #su -l "${_REMOTE_USER}" -c "az provider register --namespace Microsoft.ContainerService"
  #su -l "${_REMOTE_USER}" -c "az provider register --namespace Microsoft.KubernetesConfiguration"
  su -l "${_REMOTE_USER}" -c "az extension add -n k8s-configuration"
  su -l "${_REMOTE_USER}" -c "az extension add -n k8s-extension"
  su -l "${_REMOTE_USER}" -c "az extension add -n aks-preview"

  su -l "${_REMOTE_USER}" -c "az config set extension.use_dynamic_install=yes_without_prompt"
  su -l "${_REMOTE_USER}" -c "dotnet tool install --global Microsoft.CognitiveServices.Speech.CLI"

  if [ ! -d "${_REMOTE_USER_HOME}/.oh-my-zsh/custom" ]; then
    su -l "${_REMOTE_USER}" -c "mkdir -p ${_REMOTE_USER_HOME}/.oh-my-zsh/custom && chown $_REMOTE_USER:${_REMOTE_USER} ${_REMOTE_USER_HOME}/.oh-my-zsh/custom"
  fi
  su -l "${_REMOTE_USER}" -c "curl -L -o ${_REMOTE_USER_HOME}/.oh-my-zsh/custom/az.zsh https://raw.githubusercontent.com/Azure/azure-cli/dev/az.completion"
fi

if command -v tmux &>/dev/null; then
  su -l "${_REMOTE_USER}" -c "curl -L -o ${_REMOTE_USER_HOME}/.tmux.conf https://raw.githubusercontent.com/robinmordasiewicz/dotfiles/main/.tmux.conf"
  su -l "${_REMOTE_USER}" -c "mkdir -p ${_REMOTE_USER_HOME}/.tmux/plugins"
  su -l "${_REMOTE_USER}" -c "git clone https://github.com/tmux-plugins/tpm ${_REMOTE_USER_HOME}/.tmux/plugins/tpm"
fi

if command -v /opt/conda/bin/conda &>/dev/null; then
  su -l "${_REMOTE_USER}" -c "/opt/conda/bin/conda init --all"
  su -l "${_REMOTE_USER}" -c "/opt/conda/bin/conda config --set changeps1 False"
fi

su -l "${_REMOTE_USER}" -c "mkdir -p ~/.local/state/vs-kubernetes/tools/kubectl/"
su -l "${_REMOTE_USER}" -c "mkdir -p ~/.local/state/vs-kubernetes/tools/helm/linux-amd64/"
su -l "${_REMOTE_USER}" -c "mkdir -p ~/.local/state/vs-kubernetes/tools/minikube/linux-amd64/"
su -l "${_REMOTE_USER}" -c "mkdir -p ~/.local/state/vs-kubernetes/tools/helm/linux-arm64/"
su -l "${_REMOTE_USER}" -c "mkdir -p ~/.local/state/vs-kubernetes/tools/minikube/linux-arm64/"

su -l "${_REMOTE_USER}" -c "ln -s /usr/bin/kubectl ~/.local/state/vs-kubernetes/tools/kubectl/kubectl"
su -l "${_REMOTE_USER}" -c "ln -s /usr/bin/helm ~/.local/state/vs-kubernetes/tools/helm/linux-amd64/helm"
su -l "${_REMOTE_USER}" -c "ln -s /usr/bin/minikube ~/.local/state/vs-kubernetes/tools/minikube/linux-amd64/minikube"

su -l "${_REMOTE_USER}" -c "ln -s /usr/bin/helm ~/.local/state/vs-kubernetes/tools/helm/linux-arm64/helm"
su -l "${_REMOTE_USER}" -c "ln -s /usr/bin/minikube ~/.local/state/vs-kubernetes/tools/minikube/linux-arm64/minikube"

su -l "${_REMOTE_USER}" -c "oh-my-posh disable notice"
mkdir -p /dc/shellhistory || true
chown ${_REMOTE_USER}:${_REMOTE_USER} /dc/shellhistory || true
chown -R ${_REMOTE_USER}:${_REMOTE_USER} /home/vscode || true
