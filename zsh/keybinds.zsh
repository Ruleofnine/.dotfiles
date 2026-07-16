bindkey -e

# Better history search.
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# Ctrl+O opens lf if available.
if command -v lf >/dev/null 2>&1; then
  bindkey -s '^o' 'lfcd\n'
fi

# Ctrl+F opens fuzzy file selection in nvim.
if command -v fzf >/dev/null 2>&1; then
  bindkey -s '^f' 'vf\n'
fi

# Ctrl+E opens editor in current directory.
bindkey -s '^e' '$EDITOR .\n'
