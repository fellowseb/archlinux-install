#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source awesome-terminal-fonts font maps
source /usr/share/fonts/awesome-terminal-fonts/fontawesome-regular.sh
source /usr/share/fonts/awesome-terminal-fonts/devicons-regular.sh
source /usr/share/fonts/awesome-terminal-fonts/octicons-regular.sh
source /usr/share/fonts/awesome-terminal-fonts/pomicons-regular.sh

# Aliases
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -al'
alias grep='grep --color=auto'
alias gpg=gpg2
alias vimr='vim -R'

# Stop C^c from stopping the terminal output
stty start undef stop undef

# Env vars
export PS1="\[$(tput bold)\]\[\033[38;5;1m\]\[\033[48;5;15m\]\u\[\e[0m\]@\[\033[38;5;15m\]\[\033[48;5;1m\]\h\[\e[0m\]:\[\033[13;91;1m\]\w\[\033[48;5;1m\]\[\e[0m\] \$ "

# GPG
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye > /dev/null
unset SSH_AGENT_PID
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /home/seb/Repositories/lab/fellowseblab-resources/node_modules/tabtab/.completions/serverless.bash ] && . /home/seb/Repositories/lab/fellowseblab-resources/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /home/seb/Repositories/lab/fellowseblab-resources/node_modules/tabtab/.completions/sls.bash ] && . /home/seb/Repositories/lab/fellowseblab-resources/node_modules/tabtab/.completions/sls.bash
