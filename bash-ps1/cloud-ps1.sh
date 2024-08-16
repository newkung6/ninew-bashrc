#######################################################
# Cloud CLI ps1
#######################################################

## - Alias
alias cs='cloud_select'
alias cloudshell='gcloud cloud-shell ssh --ssh-flag=-oPreferredAuthentications=publickey --ssh-flag=-oIdentitiesOnly=yes --authorize-session'

## - cloud_select function
function cloud_select {
  _CLOUD_CONFIG_NAME=$(
    (
      ls ${CLOUDSDK_CONFIG:-~/.config/gcloud}/configurations/ 2> /dev/null | grep -v 'config_default' | sed 's/config_/GCP /g';  # GCP
      grep '^\[profile' ${AWS_CONFIG_FILE:-~/.aws/config} 2> /dev/null | sed 's/^\[profile /AWS /; s/\]//';                      # AWS
    )|fzf
  )

  case "${_CLOUD_CONFIG_NAME%% *}" in
    "AWS")
      echo "Activate AWS profile [${_CLOUD_CONFIG_NAME#* }]"
      export AWS_PROFILE=${_CLOUD_CONFIG_NAME#* }
      ;;
    "GCP")
      echo "Activated GCP profile [${_CLOUD_CONFIG_NAME#* }]"
      export CLOUDSDK_ACTIVE_CONFIG_NAME=${_CLOUD_CONFIG_NAME#* }
      ;;
    *)
      #echo "!! Unsupported cloud profile [${_CLOUD_CONFIG_NAME%% *}]"
      #exit 1
      ;;
  esac
}


function gcp_ps1 {
  gcp_profile=""
  gcp_project=""

  # Cleanup active_config
  if [[ -s ${CLOUDSDK_CONFIG:-~/.config/gcloud}/active_config ]]; then
    export CLOUDSDK_ACTIVE_CONFIG_NAME=$(cat ${CLOUDSDK_CONFIG:-~/.config/gcloud}/active_config)
    > ${CLOUDSDK_CONFIG:-~/.config/gcloud}/active_config
  fi

  if [[ -n ${CLOUDSDK_ACTIVE_CONFIG_NAME} ]]; then
    if [[ -f  ${CLOUDSDK_CONFIG:-~/.config/gcloud}/configurations/config_${CLOUDSDK_ACTIVE_CONFIG_NAME} ]]; then
      gcp_project=$(grep "project" ${CLOUDSDK_CONFIG:-~/.config/gcloud}/configurations/config_${CLOUDSDK_ACTIVE_CONFIG_NAME} | awk '{print $3}')
      # gcp_region=$(grep "region" ${CLOUDSDK_CONFIG:-~/.config/gcloud}/configurations/config_${CLOUDSDK_ACTIVE_CONFIG_NAME} | awk '{print $3}'| head -n 1)
    else
      unset CLOUDSDK_ACTIVE_CONFIG_NAME
    fi
  fi

  if [[ -n ${CLOUDSDK_ACTIVE_CONFIG_NAME} ]]; then
    #gcp_profile="${bold}${fg_red}(${fg_blue}󱇶 gcp${fg_yellow} ${gcp_project:-$CLOUDSDK_ACTIVE_CONFIG_NAME} ${fg_green}${gcp_region}${fg_red} )"
    gcp_profile="${bold}${fg_red}(${fg_blue}󱇶 GCP${fg_yellow} ${gcp_project:-$CLOUDSDK_ACTIVE_CONFIG_NAME}${fg_red})"
  fi
}

function aws_ps1 {
  aws_profile=""
  if [[ -n ${AWS_PROFILE} ]]; then
    aws_profile="${bold}${fg_red}(${fg_blue}󱇶 AWS${fg_yellow} ${AWS_PROFILE}${fg_red})"
  fi
}

