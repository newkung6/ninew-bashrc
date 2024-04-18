#!/bin/bash

# Install software
cd
mkdir -p ~/.local/bin

# tmux
sudo yum update && sudo yum install -y tmux

#yq
wget https://github.com/mikefarah/yq/releases/download/v4.27.2/yq_linux_amd64.tar.gz -O -| tar -xz && mv ~/yq_linux_amd64 ~/.local/bin/yq

#jq
wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 && chmod +x ~/jq-linux64 && mv ~/jq-linux64 ~/.local/bin/jq

#Helm
wget https://get.helm.sh/helm-v3.14.3-linux-amd64.tar.gz -O -|tar -xz && mv ~/linux-amd64/helm ~/.local/bin/helm

#Kustomize
wget https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv5.3.0/kustomize_v5.3.0_linux_amd64.tar.gz -O -| tar -xz && mv kustomize ~/.local/bin/kustomize

# FZF
wget https://github.com/junegunn/fzf/releases/download/0.48.0/fzf-0.48.0-linux_amd64.tar.gz -O -| tar -xz && mv fzf ~/.local/bin/fzf

#Flux
wget https://github.com/fluxcd/flux2/releases/download/v2.2.3/flux_2.2.3_linux_amd64.tar.gz -O -| tar -xz && mv flux ~/.local/bin/flux

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
