############################################
# Git PS1
############################################

function git_ps1() {
  # Reset variables
  g_ahead_icon=""
  g_behind_icon=""
  g_group_open=""
  g_group_close=""
  g_branch_icon=""
  g_branch=""
  g_upstream=""
  g_ahead=""
  g_behind=""
  g_change=""
  g_untrack=""

  g_status=$(git status -s -b 2> /dev/null | tr '\n' '|' |  sed -E "s/\|$//")

  if [[ -n ${g_status} ]]; then
    g_group_open="("
    g_group_close=") "

    g_branch_icon="󰘬"
    g_branch=" $(echo $g_status |sed 's/ No commits yet on//' | cut -d ' ' -f2 | sed -E "s/[\.]{3}[^[:space:]]+//" | sed "s/[\|].*//" )"
    g_upstream="$(echo $g_status | grep -E "[\.]{3}" | grep -v 'gone' > /dev/null && echo "")"
    if [[ -n ${g_upstream} ]]; then
      g_upstream=" ${g_upstream} "
    fi

    g_ahead=$(echo $g_status | grep ahead  | awk -F "ahead " '{print $2}' | awk -F '[[:space:]]|,|]' '{print $1}')
    if [[ -n ${g_ahead} ]]; then
      g_ahead_icon="  "
    fi

    g_behind=$(echo $g_status | grep behind  | awk -F "behind " '{print $2}' | awk -F '[[:space:]]|,|]' '{print $1}')
    if [[ -n ${g_behind} ]]; then
      g_behind_icon="  "
    fi

    g_change=$(echo $g_status | sed -E "s/[\|][\?]+[^\|]*//g" | grep -E "\|" > /dev/null && echo "")
    if [[ -n ${g_change} ]]; then
      g_change=" ${g_change} "
    fi

    g_untrack=$(echo $g_status | grep -E "\|[\?]{2}" > /dev/null && echo "")
    if [[ -n ${g_untrack} && -z ${g_change} ]]; then
      g_untrack=" ${g_untrack} "
    elif [[ -n ${g_untrack} ]]; then
      g_untrack="${g_untrack} "
    fi
  fi
}

