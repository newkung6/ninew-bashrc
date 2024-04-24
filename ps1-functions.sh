#!/bin/bash

function user_color {
  p_user="$(whoami)@$HOSTNAME"

  is_root=$(whoami)
  if [[ "${is_root}" == "root" ]]; then
    export usercolor="${bold}${fg_red}"
  else
    export usercolor="${bold}${fg_green}"
  fi
}

function k8s_user_color {
  # Set default (dummy) KUBECONFIG
  if [[ -z $KUBECONFIG ]]; then
    # export KUBECONFIG="${HOME}/.kube/config"
    k8s_usercolor=""
    p_k8suser=""
    p_namespace=""
  fi

  # kubeconfig per session
  if [[ ! ${KUBECONFIG} =~ /tmp/kubectx.* ]]; then
    kubeconfig_tmpfile="$(mktemp -t "kubectx.XXXXXX")"

    if [[ -f ${KUBECONFIG} ]]; then
      cp ${KUBECONFIG} ${kubeconfig_tmpfile}
      export KUBECONFIG=${kubeconfig_tmpfile}
    fi
  fi

  # Unset KUBECONFIG if no contexts
  if [[ -z $(yq e '.contexts //""' $KUBECONFIG) ]]; then
    cp $KUBECONFIG ~/.kube/config
    unset KUBECONFIG
  fi

  if [[ -n $KUBECONFIG  && -f $KUBECONFIG ]]; then
    default_kubectx=$(yq e '.contexts[0].name' $KUBECONFIG | sed 's/null//')
    export selected_kubectx=${KUBECTX:-$default_kubectx}

    # Noted. $KUBECTX is from kubectx
    # edit current context from $KUBECTX
    yq e -i '.current-context=strenv(selected_kubectx)' $KUBECONFIG

    ps1_namespace=$(yq e '.contexts[]?|select(.name==env(selected_kubectx)).context.namespace' $KUBECONFIG | sed 's/null/default/')
    p_namespace=$(echo " ($ps1_namespace)")

    export p_k8suser=$(yq e '.contexts[]?|select(.name==env(selected_kubectx)).context.cluster' $KUBECONFIG)
    export p_k8suser=${p_k8suser:-$USER}

    is_k8s_prod=$(yq e '.preferences.production' $KUBECONFIG)
    [[ $is_k8s_prod == "true" ]] && export k8s_usercolor=${bold}${fg_red} || export k8s_usercolor=${bold}${fg_yellow}
  fi

  if [[ -n "$k8s_usercolor" ]]; then
    export usercolor=${k8s_usercolor}
    export p_user="${p_k8suser}"
  fi
}

# Git branch information
function git_branch() {

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

    g_branch_icon=""
    g_branch=" $(echo $g_status |sed 's/ No commits yet on//' | cut -d ' ' -f2 | sed -E "s/[\.]{3}[^[:space:]]+//" | sed "s/[\|].*//" )"
    g_upstream="$(echo $g_status | grep -E "[\.]{3}" > /dev/null && echo "")"
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

    g_change=$(echo $g_status | sed -E "s/[\|][\?]+[^\|]*//g" | grep -E "\|" > /dev/null && echo "")
    if [[ -n ${g_change} ]]; then
      g_change=" ${g_change} "
    fi

    g_untrack=$(echo $g_status | grep -E "\|[\?]{2}" > /dev/null && echo "")
    if [[ -n ${g_untrack} && -z ${g_change} ]]; then
      g_untrack=" ${g_untrack} "
    elif [[ -n ${g_untrack} ]]; then
      g_untrack="${g_untrack} "
    fi
  fi
}

export g_branch
export g_branch_icon
export g_group_open
export g_group_close

# PS1
PLAIN_PS1='\n\[$bracketcolor\][\[$usercolor\]${p_user}\[$fg_green\]$p_namespace \[$cwdcolor\]\W\[$bracketcolor\]] \[${fg_cyan}\]${g_group_open}\[${fg_green}\]${g_branch_icon}\[${fg_cyan}\]${g_branch}\[${fg_green}\]${g_upstream}\[${fg_yellow}\]${g_ahead_icon}\[${fg_cyan}\]${g_ahead}\[${fg_yellow}\]${g_behind_icon}\[${fg_cyan}\]${g_behind}\[${fg_red}\]${g_change}\[${fg_yellow}\]${g_untrack}\[${fg_cyan}\]${g_group_close}\[${reset}\]\[$fg_white\]\$\[$resetcolor\] '

MODERN_PS1='\n \[$bracketcolor\][\[$usercolor\]${p_user}\[$fg_green\]$p_namespace \[$cwdcolor\]\W\[$bracketcolor\]] \[${fg_cyan}\]${g_group_open}\[${fg_green}\]${g_branch_icon}\[${fg_cyan}\]${g_branch}\[${fg_green}\]${g_upstream}\[${fg_yellow}\]${g_ahead_icon}\[${fg_cyan}\]${g_ahead}\[${fg_yellow}\]${g_behind_icon}\[${fg_cyan}\]${g_behind}\[${fg_red}\]${g_change}\[${fg_yellow}\]${g_untrack}\[${fg_cyan}\]${g_group_close}\[${reset}\]\n\[$fg_white\] $\[$resetcolor\] '
