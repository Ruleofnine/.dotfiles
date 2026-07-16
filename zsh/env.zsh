# ~/.config/zsh/env.zsh
#
# Shell-level environment.
# Home Manager is the source of truth on owned machines.
# This file only provides portable fallbacks for SSH/temp shells.

default_export() {
  local name="$1"
  local value="$2"

  if [[ -z "${(P)name}" ]]; then
    export "$name=$value"
  fi
}

# XDG fallbacks for non-Home-Manager systems.
default_export XDG_CONFIG_HOME "$HOME/.config"
default_export XDG_DATA_HOME   "$HOME/.local/share"
default_export XDG_CACHE_HOME  "$HOME/.cache"
default_export XDG_STATE_HOME  "$HOME/.local/state"

# Basic editor/session defaults.
default_export LANG   "en_US.UTF-8"
default_export EDITOR "nvim"
default_export VISUAL "$EDITOR"
default_export PAGER  "less"

default_export DOTFILES    "$HOME/.dotfiles"
default_export CODEDIR     "$HOME/coding"
default_export SCRIPTS_DIR "$HOME/.local/scripts"

# Zsh-owned state. This belongs here, not really in Home Manager.
mkdir -p "$XDG_STATE_HOME/zsh" "$XDG_CACHE_HOME/zsh"

export HISTFILE="$XDG_STATE_HOME/zsh/history"
export HISTSIZE=100000
export SAVEHIST=100000

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

# Tool fallbacks for portable shells.
# On Arbacus/Nower, Home Manager should already set these.
default_export CARGO_HOME "$XDG_DATA_HOME/cargo"
default_export RUSTUP_HOME "$XDG_DATA_HOME/rustup"
default_export GOPATH "$XDG_DATA_HOME/go"
default_export PUB_CACHE "$XDG_DATA_HOME/pub-cache"
default_export GRADLE_USER_HOME "$XDG_DATA_HOME/gradle"

default_export ODBCINI "$XDG_CONFIG_HOME/odbc/odbc.ini"

default_export TF_CLI_CONFIG_FILE "$XDG_CONFIG_HOME/terraform/terraform.tfrc"
default_export TF_PLUGIN_CACHE_DIR "$XDG_CACHE_HOME/terraform/plugin-cache"

default_export OLLAMA_MODELS "$XDG_DATA_HOME/ollama/models"

default_export NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
default_export NPM_CONFIG_CACHE "$XDG_CACHE_HOME/npm"
default_export NPM_CONFIG_PREFIX "$XDG_DATA_HOME/npm"

default_export LESSHISTFILE "$XDG_STATE_HOME/less/history"
mkdir -p "${LESSHISTFILE:h}"

# Portable PATH additions.
# Home Manager also handles PATH, but this helps when the zsh config is copied
# to a random SSH box.
path_prepend_if_exists() {
  local dir="$1"

  [[ -d "$dir" ]] || return 0

  if (( ! ${path[(Ie)$dir]} )); then
    path=("$dir" $path)
  fi
}

path_prepend_if_exists "$HOME/.local/bin"
path_prepend_if_exists "$HOME/.local/scripts"
path_prepend_if_exists "${CARGO_HOME:-$XDG_DATA_HOME/cargo}/bin"
path_prepend_if_exists "${NPM_CONFIG_PREFIX:-$XDG_DATA_HOME/npm}/bin"
path_prepend_if_exists "${GOPATH:-$XDG_DATA_HOME/go}/bin"
path_prepend_if_exists "$HOME/.nix-profile/bin"

typeset -U path

# Defensive fallback for a damaged or minimal PATH.
for system_dir in /usr/local/bin /usr/bin /bin; do
  if [[ -d "$system_dir" ]] && (( ! ${path[(Ie)$system_dir]} )); then
    path+=("$system_dir")
  fi
done

export PATH
