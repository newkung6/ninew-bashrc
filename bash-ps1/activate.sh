#####################################################################
# Activate PS1
#####################################################################

## - Locating scripts directory
# SCRIPT_DIR=$(dirname ${BASH_SOURCE[0]})
SCRIPT_DIR=$(dirname ${BASH_SOURCE[0]})

## - Loading color scheme
source $SCRIPT_DIR/color-scheme.sh

## - Loading utils functions
source $SCRIPT_DIR/user-ps1.sh
source $SCRIPT_DIR/git-ps1.sh
source $SCRIPT_DIR/k8s-ps1.sh
source $SCRIPT_DIR/cloud-ps1.sh


## - Activate utils functions
PROMPT_COMMAND="user_ps1; git_ps1; k8s_ps1; aws_ps1; gcp_ps1 > /dev/null;"

## - PS1
PS1='\n\[$bracketcolor\][\[$usercolor\]${p_user}\[$fg_green\]$p_namespace \[$cwdcolor\]\W\[$bracketcolor\]] \[${fg_cyan}\]${g_group_open}\[${fg_green}\]${g_branch_icon}\[${fg_cyan}\]${g_branch}\[${fg_green}\]${g_upstream}\[${fg_yellow}\]${g_ahead_icon}\[${fg_cyan}\]${g_ahead}\[${fg_yellow}\]${g_behind_icon}\[${fg_cyan}\]${g_behind}\[${fg_red}\]${g_change}\[${fg_yellow}\]${g_untrack}\[${fg_cyan}\]${g_group_close}${gcp_profile}${aws_profile}\[${reset}\]\n\[$fg_white\]\[$resetcolor\] '


