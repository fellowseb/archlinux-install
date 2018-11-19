# XDG dir spec compliance
export LESSHISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}"/less/history
export LESSKEY="${XDG_CONFIG_HOME:-$HOME/.config}"/less/conf

# Formatting / coloring
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;34m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_so=$'\e[38;5;16;48;5;4;1m'
export LESS_TERMCAP_se=$'\e[39;49m'
export LESS_TERMCAP_us=$'\e[4;96m'
export LESS_TERMCAP_ue=$'\e[0m'
