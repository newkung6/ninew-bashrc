#####################################################
# Kubernetes PS1
#####################################################

## - Aliases
alias k='kubectl'
alias ks='kubeselect'
alias ns='kubens'

## - Bash completion
complete -o default -F __start_kubectl k

KUBECONFIG_DIR="${KUBECONFIG_DIR:-$HOME/.kube}"

## - list kubecontext
function kubecontext_list() {
  for config in $(fd -e yaml . $KUBECONFIG_DIR); do
    DISP_CONFIG_FILE=$(echo $config | sed "s|$KUBECONFIG_DIR/||")
    for context in $(yq e '.contexts[].name' $config); do
      DISP_CONTEXT="$DISP_CONFIG_FILE // $context"
      echo $DISP_CONTEXT
    done
  done
}

## - kubeselect
function kubeselect() {
  DISP_SELECTED=$(kubecontext_list | fzf)
  export KUBECONFIG="${KUBECONFIG_DIR}/${DISP_SELECTED%% // *}"
  export KUBECTX="${DISP_SELECTED##* // }"
  echo $KUBECONFIG
  echo $KUBECTX
}


## - K8S PS1
function k8s_ps1 {
  # Set default (dummy) KUBECONFIG
  if [[ -z $KUBECONFIG ]]; then
    # export KUBECONFIG="${HOME}/.kube/config"
    k8s_usercolor=""
    p_k8suser=""
    p_namespace=""
  fi

  # Create alias k3d.yaml from ~/.kube/config
  if [[ ! -f ~/.kube/k3d.yaml ]] && [[ -f ~/.kube/config ]] && [[ $(yq e '.current-context' ~/.kube/config) =~ "k3d" ]]; then
    ln -sf ~/.kube/config ~/.kube/k3d.yaml
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
    rm -f ~/.kube/k3d.yaml
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
