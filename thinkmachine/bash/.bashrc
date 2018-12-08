#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#
# Aliases
#
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -al'
alias grep='grep --color=auto'

#
# Stop C^c from stopping the terminal output
#
stty start undef stop undef

#
# Customisation
#

prompt_helper_codepoint() {
  local tty=$(tty) 
  tty=${tty:5}
  tty=${tty:0:3}
  if [ $tty = "tty" ]; then
    echo -e -n $2
  else
    echo -e -n "\u$1"
  fi
}

prompt_helper_ret_status() {
  if [ $1 -gt 0 ]; then
    echo -e "\033[1;38;5;1m\uf071 ${1#0}\e[0m"
    echo " "
  fi
}

prompt_helper_user_hostname() {
  echo -n -e "$(tput bold)\033[1;38;5;4m$(prompt_helper_codepoint f007 ) $1\e[0m@\033[38;5;15m\033[48;5;0m$2\e[0m"
}

prompt_helper_home_is_tilde() {
  if [ ${1:0:${#HOME}} = $HOME ]; then
    echo -n ~${1:${#HOME}}
  else
    echo -n ${1}
  fi
}

prompt_helper_workdir() {
  echo -n -e "\033[38;5;172m\uf07b $(prompt_helper_home_is_tilde $1)\033[48;5;1m\e[0m"
}

prompt_helper_git_status() {
  if git status &> /dev/null; then
    local status=$(git status -b -s)
    echo
    echo -n -e '\033[38;5;198m\uf126 '
    echo -n "$status" | head -1 | sed 's/## //g' | sed $'s/\.\.\./ \uf061 /g' | tr -d '\n'
    echo -n -e ' \uf059'
    echo -n "$status" | tail -n+1 | grep -c -e "^?? " | tr -d '\n'
    echo -n -e ' \uf0fe'
    echo -n "$status" | tail -n+1 | grep -c -e "^A " | tr -d '\n'
    echo -n -e ' \uf146'
    echo -n "$status" | tail -n+1 | grep -c -e "^ D " | tr -d '\n'
    echo -n -e '\e[0m'
  fi
}

PS1='$(prompt_helper_ret_status $?)\n$(prompt_helper_user_hostname \u \h)\n$(prompt_helper_workdir \w)$(prompt_helper_git_status)\n\$ '

# Load scriptlets from ~/.config/bash/bashrc.d
if test -d "${XDG_CONFIG_HOME:-$HOME/.config}"/bash/bashrc.d/; then
  for scriptlet in "${XDG_CONFIG_HOME:-$HOME/.config}"/bash/bashrc.d/*.bash; do
    test -r "$scriptlet" && . "$scriptlet"
  done
  unset scriptlet
fi
