###########################################
# Activate BASH 
###########################################
## - set local
ninew-bashrc


## - Locating scripts directory
BASH_CUSTOM_SCRIPT_DIR=$(dirname ${BASH_SOURCE[0]})
BASH_CUSTOM_SCRIPT_DIR= "~/.local/ninew-bashrc"

## - Activate PS1
source $BASH_CUSTOM_SCRIPT_DIR/bash-ps1/activate.sh

## - Activate utils
source $BASH_CUSTOM_SCRIPT_DIR/utils/activate.sh

## - Activate FZF
source $BASH_CUSTOM_SCRIPT_DIR/fzf/activate.sh

## - Activate BAT
# source $BASH_CUSTOM_SCRIPT_DIR/bat/activate.sh

## - Activate ca-certificate
# source $BASH_CUSTOM_SCRIPT_DIR/ca-bundle-keychain/activate.sh





