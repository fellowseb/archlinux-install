# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lABhF --group-directories-first'
alias grep='grep --color=auto'

# Stop C^c from stopping the terminal output
stty start undef stop undef

# Customisation
. ~/.config/bash/prompt_helpers.bash

PS1='$(prompt_helper_ret_status $?)\n$(prompt_helper_user_hostname \u \h)\n$(prompt_helper_workdir \w)$(prompt_helper_git_status)\n\$ '

# Load scriptlets from ~/.config/bash/bashrc.d
if test -d "${XDG_CONFIG_HOME:-$HOME/.config}"/bash/bashrc.d/; then
  for scriptlet in "${XDG_CONFIG_HOME:-$HOME/.config}"/bash/bashrc.d/*.bash; do
    test -r "$scriptlet" && . "$scriptlet"
  done
  unset scriptlet
fi
