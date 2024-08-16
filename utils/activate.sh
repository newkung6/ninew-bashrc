##########################################
# Generic settings
##########################################

alias ls='ls --color=auto'
alias grep='grep --color'
alias ddu='du -sch .[!.]* * |sort -h'
alias watch='watch '

# Random password

genpassword() {
  openssl rand -base64 24 | tr -dc 'A-Za-z0-9!@$%^&*()_+-=' | head -c ${1:-32}
}


# Random token
gentoken() {
  openssl rand -base64 24 | tr -dc 'A-Za-z0-9' | head -c ${1:-32}
}
