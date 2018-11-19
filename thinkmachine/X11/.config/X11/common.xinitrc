#!/bin/sh

userresources="${XDG_CONFIG_HOME:-$HOME/.config}"/X11/Xresources
userresourcesdir="${XDG_CONFIG_HOME:-$HOME/.config}"/X11/Xresources.d
usermodmap="${XDG_CONFIG_HOME:-$HOME/.config}"/X11/Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# Merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# Merge in ~/.config/X11/Xresources.d/*.xrdb
if [ -d "${userresourcesdir}" ] ; then
 for f in "${userresourcesdir}"/?*.xrdb ; do
   xrdb -merge "${f}"
 done
 unset f
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

amixer set "Master" mute &
xbindkeys --file "${XDG_CONFIG_HOME:-$HOME/.config}"/xbindkeys/config
