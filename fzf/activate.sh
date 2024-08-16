#!/bin/bash

################################################
# FZF activation
################################################
# SCRIPT_DIR=$(dirname ${BASH_SOURCE[0]})
SCRIPT_DIR=$(dirname ${BASH_SOURCE[0]})

export FZF_TMUX_HEIGHT=40%
export FZF_CTRL_SPACE_COMMAND="(fd -tf -tl -td -d 1 . ~/Downloads && fd -tf -tl -td -d 1 . $pwd)"
export FZF_CTRL_SPACE_OPTS="--preview 'bat --style=numbers --color=always {}'"
export FZF_WORKSPACE_COMMAND="(echo ~/Downloads/ &&  fd  -t d -H -g -p -u '**/.git' ~/workspaces/ | sed -E 's:/.git/$::g' 2> /dev/null)"
source $SCRIPT_DIR/fzf-key-binding.bash

# new
#source $SCRIPT_DIR/key-bindings.bash
