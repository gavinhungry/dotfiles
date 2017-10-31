__commands() {
  COMPREPLY=($(compgen -c -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F __commands cw ew

__users() {
  COMPREPLY=($(compgen -u -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F __users gecos

__packages() {
  COMPREPLY=($(compgen -W '$(pacman -Sqs); $(pacman -Qqs)' -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F __packages pkgsource

__pnames() {
  local cur prev words cword
  _init_completion || return
  _pnames "$cur"
}
complete -F __pnames pidage pidenv pkg psof

__modparam() {
  local cur prev words cword
  _init_completion || return
  _installed_modules "$cur"
}
complete -F __modparam modparam

_completion_loader journalctl
complete -F _journalctl jc

_completion_loader pacman
complete -o default -F _pacman packer

_completion_loader systemctl
complete -F _systemctl sc
