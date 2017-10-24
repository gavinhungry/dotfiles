__packages() {
  local cur
  cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=($(compgen -W "$(pacman -Sqs); $(pacman -Qqs)" -- ${cur}))
}

__pnames() {
  local cur prev words cword
  _init_completion || return
  _pnames
}

complete -F __packages pkgsource
complete -F __pnames psof

