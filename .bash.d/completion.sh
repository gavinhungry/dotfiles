#!/bin/bash

if [ -f /etc/profile.d/bash_completion.sh ]; then
  source /etc/profile.d/bash_completion.sh
fi

export COMP_KNOWN_HOSTS_WITH_AVAHI=
export COMP_KNOWN_HOSTS_WITH_HOSTFILE=

type _completion_loader &> /dev/null || _completion_loader() { false ;}

__commands() {
  COMPREPLY=($(compgen -c -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F __commands cw ew lw ow pkgw emi

__users() {
  COMPREPLY=($(compgen -u -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F __users gecos

__packages() {
  COMPREPLY=($(compgen -W '$(pacman -Sqs); $(pacman -Qqs)' -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F __packages pkgsource

__local_packages() {
  COMPREPLY=($(compgen -W '$(pacman -Qqs)' -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F __local_packages pkgver

__pnames() {
  local cur prev words cword
  _init_completion || return
  _pnames "$cur"
}
complete -F __pnames pidage pidenv psof

__modparam() {
  local cur prev words cword
  _init_completion || return
  _installed_modules "$cur"
}
complete -F __modparam modparam

_completion_loader journalctl
complete -F _journalctl jc

_completion_loader man
complete -F _man eman

_completion_loader systemctl
complete -F _systemctl sc

_completion_loader ssh
complete -F _comp_cmd_ssh ssh-mount ssh-umount ssh-host

__ai_models_complete() {
  local cur=${COMP_WORDS[$COMP_CWORD]}
  _init_completion -n : cur

  local models
  models=$(ollama ls | tail -n+2 | awk '{print $1}' | sort)

  COMPREPLY=( $(compgen -W "$models" -- "$cur" ) )
  __ltrim_colon_completions "$cur"
}
complete -F __ai_models_complete ai
