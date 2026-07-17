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

__ai_complete() {
  local cur=${COMP_WORDS[$COMP_CWORD]}
  _init_completion -n : cur

  if [[ $cur == -* ]]; then
    COMPREPLY=( $(compgen -W "--think --verbose --edit" -- "$cur") )
    return
  fi

  local i
  for (( i=1; i<COMP_CWORD; i++ )); do
    [[ ${COMP_WORDS[i]} != -* ]] && return
  done

  local models
  models=$(ollama ls | tail -n+2 | awk '{print $1}' | sort)

  COMPREPLY=( $(compgen -W "$models" -- "$cur") )
  __ltrim_colon_completions "$cur"
}
complete -F __ai_complete ai

__github_complete() {
  local cur prev
  cur="${COMP_WORDS[COMP_CWORD]}"

  local subcommands="commits commit head issues issue pulls pull prs pr actions ci settings"
  COMPREPLY=($(compgen -W "$subcommands" -- "$cur"))
}

complete -F __github_complete github

__trunk_complete() {
  local cur

  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}

  if (( COMP_CWORD == 1 )); then
    COMPREPLY=( $(compgen -W 'open close list status' -- "$cur") )
    return
  fi

  case ${COMP_WORDS[1]} in
    open)
      if (( COMP_CWORD == 2 )); then
        COMPREPLY=( $(compgen -W "auto $(trunk list 2>/dev/null)" -- "$cur") )
      fi
    ;;
  esac
}

complete -F __trunk_complete trunk
