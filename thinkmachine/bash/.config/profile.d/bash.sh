# XDG dir spec compliance
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}"/bash/history_$(date +%Y_%W)
( mkdir -p $(dirname $HISTFILE) | true ) 2>/dev/null
