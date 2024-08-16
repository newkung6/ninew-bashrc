# backup .bashrc
cp ~/.bashrc ~/.bashrc.orig

PATH_BASH=$(dirname ${BASH_SOURCE[0]})

# # install dotfiles
cp $PATH_BASH/.bashrc ~/
cp $PATH_BASH/.vimrc ~/
cp $PATH_BASH/.tmux.conf ~/





