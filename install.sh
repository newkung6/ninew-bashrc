#!/bin/bash

PATH_LOCAL_BIN="~/usr/local/bin"

# Install software
cd
mkdir -p $PATH_LOCAL_BIN

# tmux
sudo yum update && sudo yum install -y tmux

#yq
wget https://github.com/mikefarah/yq/releases/download/v4.27.2/yq_linux_amd64.tar.gz -O -| tar -xz && sudo mv ~/yq_linux_amd64 $PATH_LOCAL_BIN/yq

#jq
wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 && chmod +x ~/jq-linux64 && sudo mv ~/jq-linux64 $PATH_LOCAL_BIN/jq

#Helm
wget https://get.helm.sh/helm-v3.14.3-linux-amd64.tar.gz -O -|tar -xz && sudo mv ~/linux-amd64/helm $PATH_LOCAL_BIN/helm

#Kustomize
wget https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv5.3.0/kustomize_v5.3.0_linux_amd64.tar.gz -O -| tar -xz && sudo mv kustomize $PATH_LOCAL_BIN/kustomize

# FZF
wget https://github.com/junegunn/fzf/releases/download/0.48.0/fzf-0.48.0-linux_amd64.tar.gz -O -| tar -xz && sudo mv fzf $PATH_LOCAL_BIN/fzf

#Flux
wget https://github.com/fluxcd/flux2/releases/download/v2.2.3/flux_2.2.3_linux_amd64.tar.gz -O -| tar -xz && sudo mv flux $PATH_LOCAL_BIN/flux

# Install bash completion
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl
helm completion bash | sudo tee /etc/bash_completion.d/helm
flux completion bash | sudo tee /etc/bash_completion.d/flux
kustomize completion bash | sudo tee /etc/bash_completion.d/kustomize

# backup .bashrc
cp ~/.bashrc ~/.bashrc.orig

# install dotfiles
cp ~/.dotfiles/.bashrc ~/
cp ~/.dotfiles/.vimrc ~/
cp ~/.dotfiles/.tmux.conf ~/
