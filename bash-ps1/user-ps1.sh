######################################
# PS1 User color
######################################

function user_ps1 {
  p_user="$(whoami)@$HOSTNAME"

  if [[ "${USER}" == "root" ]]; then
    export usercolor="${bold}${fg_red}"
  else
    export usercolor="${bold}${fg_green}"
  fi
}

