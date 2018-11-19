#
# ~/.bash_profile
#

# Source .profile to get shell-agnostic env vars settings
[[ -f ~/.profile ]] && . ~/.profile

# Source .bashrc to get same customization and aliases as non-login shells
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Launch login manager
tdm
