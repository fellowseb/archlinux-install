#
# Aliases
#
alias gpg=gpg2

# See man gpg-agent
export GPG_TTY=$(tty)

is_ssh_support_enabled() {
  [ $(gpgconf -q --list-options gpg-agent |
  grep "enable-ssh-support" | 
  awk -F: '{ print $10 != "" ? $10 : $8 }' -) == 1 ]
}

if whereis -b gpgconf > /dev/null && is_ssh_support_enabled; then
  gpg-connect-agent updatestartuptty /bye > /dev/null
  unset SSH_AGENT_PID
  if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  fi
fi

unset is_ssh_support_enabled
