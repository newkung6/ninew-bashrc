#!/bin/bash

##############################################
# Solarize terminal color code 
##############################################

normal=$(tput rmul)$(tput dim)
reset=$(tput sgr0)
underline=$(tput smul)
normalline=$(tput rmul)
blink=$(tput blink)
bold=$(tput bold)
dim=$(tput dim)
rev=$(tput rev)
fg_black=$(tput setaf 0)
fg_red=$(tput setaf 1)
fg_green=$(tput setaf 2)
fg_yellow=$(tput setaf 3)
fg_blue=$(tput setaf 4)
fg_magenta=$(tput setaf 5)
fg_cyan=$(tput setaf 6)
fg_white=$(tput setaf 7)

bg_black=$(tput setab 0)
bg_red=$(tput setab 1)
bg_green=$(tput setab 2)
bg_yellow=$(tput setab 3)
bg_blue=$(tput setab 4)
bg_magenta=$(tput setab 5)
bg_cyan=$(tput setab 6)
bg_white=$(tput setab 7)

bracketcolor=$(tput bold; tput setaf 1) # Bold red
cwdcolor=$(tput bold; tput setaf 4) # Bold blue
resetcolor=$(tput sgr0) #reset
