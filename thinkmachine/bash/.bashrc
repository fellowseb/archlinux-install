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
# source /usr/share/fonts/awesome-terminal-fonts/fontawesome-regular.sh
# source /usr/share/fonts/awesome-terminal-fonts/devicons-regular.sh
# source /usr/share/fonts/awesome-terminal-fonts/octicons-regular.sh
# source /usr/share/fonts/awesome-terminal-fonts/pomicons-regular.sh
export PS1='\[\033[1;38;5;1m\]${?#0}\[\e[0m\]\n\[$(tput bold)\]\[\033[1;38;5;4m\]\u\[\e[0m\]@\[\033[38;5;15m\]\[\033[48;5;1m\]\h\[\e[0m\]:\[\033[13;91;1m\]\w\[\033[48;5;1m\]\[\e[0m\] \$ '

# Load scriptlets from ~/.config/bash/bashrc.d
if test -d "${XDG_CONFIG_HOME:-$HOME/.config}"/bash/bashrc.d/; then
  for scriptlet in "${XDG_CONFIG_HOME:-$HOME/.config}"/bash/bashrc.d/*.bash; do
    test -r "$scriptlet" && . "$scriptlet"
  done
  unset scriptlet
fi
