#!/bin/sh

# Source common xinitrc file
if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/X11/common.xinitrc ]; then
  source "${XDG_CONFIG_HOME:-$HOME/.config}"/X11/common.xinitrc
fi

whereis compton > /dev/null && compton -b --config ~/.config/compton/conf &
exec awesome
