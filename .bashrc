#
# ~/.bashrc
#

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

####################################
# Custom Environment Variables
####################################

# global
EDITOR="/usr/bin/vi"

# bat
# BAT_THEME="Solarized (dark)"

# fzf
export FZF_TMUX_HEIGHT=40%
export FZF_CTRL_SPACE_COMMAND="(fd -tf -tl -td -d 1 . ~/Downloads && fd -tf -tl -td -d 1 . $pwd)"
export FZF_CTRL_SPACE_OPTS="--preview 'bat --style=numbers --color=always {}'"
export FZF_WORKSPACE_COMMAND="(echo ~/Downloads/ &&  find ~/workspace -type d -name '.git' | sed -E 's:/.git$::g' 2> /dev/null)"

source ~/.dotfiles/fzf-key-binding.bash

#####################################
# Custom modifications
####################################

# VI editing mode
set -o vi

# Enable tabs 2
tabs 2

# Solarized terminal color code
. ~/.dotfiles/color-scheme.sh

# Import prompt functions
. ~/.dotfiles/ps1-functions.sh


####################################

for file in /etc/bash_completion.d/*; do
  [ -r "$file" ] && source "$file"
done


# kubectl
alias k='kubectl'
complete -o default -F __start_kubectl k

# kubeselect kubens
# alias ks='eval $(kubeselect select)'
alias ks='export KUBECONFIG="$(ls ~/.kube/*.yaml | fzf)"'

#alias ns='kubens'
function kns {
  selected_ns=$(kubectl get ns -o name |awk -F / '{print $2}' | fzf)
  kubectl config set-context --current --namespace=$selected_ns
}

# watch
alias watch='watch '

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*|screen*|tmux*)
    # PROMPT_COMMAND="user_color > /dev/null; k8s_user_color; git_branch > /dev/null;"
    PROMPT_COMMAND="user_color > /dev/null; k8s_user_color > /dev/null; git_branch > /dev/null;"

    # Use PS1 in /opt/bash/ps1-functions.sh
    PS1=$MODERN_PS1

    ;;
  *)
    PROMPT_COMMAND="git_branch > /dev/null;"
    setterm -cursor on
    cursor_styles="\e[?${cursor_style_full_block};"
    PS1='\n\[$bracketcolor\][\[$cwdcolor\]\W\[$bracketcolor\]] \[${fg_cyan}\]${g_group_open}\[${fg_cyan}\]${g_branch}\[${fg_cyan}\]${g_group_close}\[${reset}\]\[$fg_white\]\$\[$resetcolor\] '

    ;;
esac

export PS1