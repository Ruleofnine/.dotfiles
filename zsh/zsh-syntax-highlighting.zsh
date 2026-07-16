# NixOS may already have loaded it globally.
if (( ! ${+functions[_zsh_highlight]} )); then
  _zsh_highlighting_candidates=(
    /etc/profiles/per-user/$USER/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    "$HOME/.nix-profile/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    /run/current-system/sw/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  )

  for _plugin in "${_zsh_highlighting_candidates[@]}"; do
    if [[ -r "$_plugin" ]]; then
      source "$_plugin"
      break
    fi
  done

  unset _plugin _zsh_highlighting_candidates
fi
