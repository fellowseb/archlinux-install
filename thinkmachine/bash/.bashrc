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
print_ret_status() {
  if [ $1 -gt 0 ]; then
    echo -e "\033[1;38;5;1m\uf071 ${1#0}\e[0m"
    echo " "
  fi
}

print_user_hostname() {
  echo -n -e "$(tput bold)\033[1;38;5;4m\uf007 $1\e[0m \uf108 \033[38;5;15m\033[48;5;0m$2\e[0m"
}

print_workdir() {
  echo -n -e "\033[38;5;172m\uf07b $1\033[48;5;1m\e[0m"
}

print_git_status() {
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
PS1='$(print_ret_status $?)\n$(print_user_hostname \u \h)\n$(print_workdir \w)$(print_git_status)\n\$ '

# Load scriptlets from ~/.config/bash/bashrc.d
if test -d "${XDG_CONFIG_HOME:-$HOME/.config}"/bash/bashrc.d/; then
  for scriptlet in "${XDG_CONFIG_HOME:-$HOME/.config}"/bash/bashrc.d/*.bash; do
    test -r "$scriptlet" && . "$scriptlet"
  done
  unset scriptlet
fi
