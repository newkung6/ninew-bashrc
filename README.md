# Dotfiles for AWS bastion host


## Prerequisite

- git
- kustomize
- kubectl
- kubeselect
- yq
- tmux
- tmuxinator
- helm
---
## Instructions

1. Clone this repository to `~/.dotfiles`
    ```sh
    git clone https://github.com/newkung6/ninew-bashrc ~/.dotfiles
    ```
2. Initial setup

    ```sh
    cp ~/.dotfiles/.vimrc ~/
    cp ~/.dotfiles/.tmux.conf ~/

    ```

---
## Usage

Create new session `demo`

```sh
tmux new -s demo
```
---
## custom tmux

```sh
sudo yum install gcc  libevent-devel ncurses-devel

wget https://github.com/tmux/tmux/releases/download/3.2/tmux-3.2.tar.gz

tar -xvf tmux-3.2.tar.gz

cd tmux-3.2
./configure && make
sudo make install


```