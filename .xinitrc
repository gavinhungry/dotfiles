#!/bin/bash

export X_TTY=$(tty)
export XDG_CURRENT_DESKTOP=XFCE

xrdb -merge ~/.Xresources
xset +fp /usr/share/fonts/local
xset fp rehash

xhost +si:localuser:root

. /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

[ -r $HOME/.xinitrc.local ] && . $HOME/.xinitrc.local

exec xfce4-session
