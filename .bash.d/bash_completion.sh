#!/bin/bash

shopt -s nullglob

if [ -f /etc/profile.d/bash_completion.sh ]; then
  source /etc/profile.d/bash_completion.sh
fi

type _completion_loader &> /dev/null || _completion_loader() { false ;}

for COMP in $HOME/.bash.d/bash-completion/*; do
  [ -f "$COMP" ] && source "$COMP"
done
