#####################################################
# Scripts for generate CA bundle from Apple Keychain
# for curl and wget
#
# Assume that CA already added in Keychain and trusted
#####################################################

function get-ca-certificates() {
  if [ "$#" -lt 1 ]
  then
    echo "Error: No REMOTE_HOST argument provided"
    echo "Usage: $FUNCNAME <REMOTE_HOST> [REMOTE_PORT (default 443)] "
  fi


  REMOTE_HOST=$1
  REMOTE_PORT=$2
  openssl s_client -showcerts -verify 5 -connect ${REMOTE_HOST}:${REMOTE_PORT:-443} -servername $REMOTE_HOST < /dev/null 2> /dev/null | awk '/BEGIN/,/END/{ if(/BEGIN/){a++}; print}'

}

export SSL_CERT_FILE=/tmp/ca-bundles.pem

function update-ca-certificates() {
  cp /etc/ssl/cert.pem $SSL_CERT_FILE
  security find-certificate -a -p >> $SSL_CERT_FILE
}

[[ -r "${SSL_CERT_FILE}" ]] || update-ca-certificates
