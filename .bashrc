# ~/.bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi

for file in /etc/bash_completion.d/*; do
  [ -r "$file" ] && source "$file"
done

####################################
# Custom Environment Variables
####################################

# global
EDITOR="/usr/bin/vi"

BASH_CUSTOM_SCRIPT_DIR=$HOME/.local/ninew-bashrc

## - Activate FZF
source $BASH_CUSTOM_SCRIPT_DIR/fzf/activate.sh

## - Activate PS1
source $BASH_CUSTOM_SCRIPT_DIR/bash-ps1/activate.sh

## - Activate utils
source $BASH_CUSTOM_SCRIPT_DIR/utils/activate.sh

## - Activate BAT
# source $BASH_CUSTOM_SCRIPT_DIR/bat/activate.sh

## - Activate ca-certificate
# source $BASH_CUSTOM_SCRIPT_DIR/ca-bundle-keychain/activate.sh

####################################
