#!/bin/bash

[ -r $HOME/.xinitrc.local ] && . $HOME/.xinitrc.local

xset +fp /usr/share/fonts/local
xset fp rehash

xmodmap $HOME/.Xmodmap
xbindkeys

export DE=xfce
exec startxfce4
