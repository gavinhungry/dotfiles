#!/bin/bash

shopt -s nullglob

if [ -f /etc/profile.d/bash_completion.sh ]; then
  source /etc/profile.d/bash_completion.sh
fi

type _completion_loader &> /dev/null || _completion_loader() { false ;}

_completion_loader journalctl
complete -F _journalctl jc

_completion_loader systemctl
complete -F _systemctl sc

for COMP in $HOME/bin/.bash-completion/*; do
  [ -f "$COMP" ] && source "$COMP"
done
