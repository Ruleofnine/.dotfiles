# ~/.config/zsh/functions.zsh

mkcd() {
  mkdir -p "$1" && cd "$1"
}

take() {
  mkcd "$1"
}

extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz)  tar xzf "$1" ;;
      *.bz2)     bunzip2 "$1" ;;
      *.rar)     unrar x "$1" ;;
      *.gz)      gunzip "$1" ;;
      *.tar)     tar xf "$1" ;;
      *.tbz2)    tar xjf "$1" ;;
      *.tgz)     tar xzf "$1" ;;
      *.zip)     unzip "$1" ;;
      *.Z)       uncompress "$1" ;;
      *.7z)      7z x "$1" ;;
      *)         echo "Cannot extract: $1" ;;
    esac
  else
    echo "Not a file: $1"
  fi
}
unalias ls 2>/dev/null
ls() {
  if command -v eza >/dev/null 2>&1; then
    eza -al --color=always --group-directories-first "$@" | grep -v "^l"
  else
    command ls -lah --color=auto "$@"
  fi
}

home-audit-fresh() {
  echo "Real top-level dotfiles/dirs:"
  home-audit-real 2>/dev/null || {
    find "$HOME" -maxdepth 1 -mindepth 1 ! -type l -printf '%f\n' \
      | sort \
      | grep '^\.' || true
  }
}

path-lines() {
  echo "$PATH" | tr ':' '\n'
}

path-has() {
  path-lines | grep -Fx "$1" >/dev/null
}

reload-zsh() {
  source "$ZDOTDIR/.zshrc"
}

weather-lab() {
  curl -s "wttr.in?format=3"
}

serve-here() {
  local port="${1:-8000}"
  python -m http.server "$port"
}

backup-now() {
  echo "Backup command not wired yet."
  return 1
}

# lf cd helper.
if command -v lf >/dev/null 2>&1; then
  lfcd() {
    local tmp
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"

    if [ -f "$tmp" ]; then
      local dir
      dir="$(cat "$tmp")"
      rm -f "$tmp"

      if [ -d "$dir" ] && [ "$dir" != "$(pwd)" ]; then
        cd "$dir"
      fi
    fi
  }
fi

# fzf file edit helper.
vf() {
  if command -v fzf >/dev/null 2>&1; then
    local file
    file="$(fzf)" && "$EDITOR" "$file"
  else
    echo "fzf not installed"
    return 1
  fi
}
