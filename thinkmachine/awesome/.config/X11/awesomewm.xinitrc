#!/bin/sh

# Source common xinitrc file
if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/X11/common.xinitrc ]; then
  source "${XDG_CONFIG_HOME:-$HOME/.config}"/X11/common.xinitrc
fi

set -a
source /usr/share/fonts/awesome-terminal-fonts/fontawesome-regular.sh
set +a
exec awesome
