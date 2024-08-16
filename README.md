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
## Preinstall



## Instructions

1. Clone this repository to `~/.local`
    ```sh
    git clone https://github.com/newkung6/ninew-bashrc ~/.local/ninew-bashrc
    ```
2. Initial setup

    ```sh
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