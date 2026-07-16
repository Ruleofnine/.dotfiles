# ~/.config/zsh/.zshrc

# Load Home Manager session vars when available.
# This matters on Arch/Home Manager so CARGO_HOME, RUSTUP_HOME, XDG vars, etc. exist.
if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
  source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi

# XDG fallbacks for systems without Home Manager.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

export ZSH_CONFIG="${ZSH_CONFIG:-$XDG_CONFIG_HOME/zsh}"
export RULE_HOST="${RULE_HOST:-${HOST%%.*}}"

source_if_exists() {
  [ -r "$1" ] && source "$1"
}

# Core shared config.
source_if_exists "$ZSH_CONFIG/env.zsh"
source_if_exists "$ZSH_CONFIG/completion.zsh"
source_if_exists "$ZSH_CONFIG/aliases.zsh"
source_if_exists "$ZSH_CONFIG/functions.zsh"
source_if_exists "$ZSH_CONFIG/keybinds.zsh"
# OS-specific config.
if [ -f /etc/NIXOS ]; then
  source_if_exists "$ZSH_CONFIG/os/nixos.zsh"
elif [ -f /etc/arch-release ]; then
  source_if_exists "$ZSH_CONFIG/os/arch.zsh"
fi

# Host-specific config.
source_if_exists "$ZSH_CONFIG/hosts/$RULE_HOST.zsh"

# Machine-local private overrides.
source_if_exists "$ZSH_CONFIG/local.zsh"
source_if_exists "$ZSH_CONFIG/prompt.zsh"
source_if_exists "$ZSH_CONFIG/zsh-syntax-highlighting.zsh"
