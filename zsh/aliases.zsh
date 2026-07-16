# ~/.config/zsh/aliases.zsh

alias c='clear'
alias q='exit'
alias v='$EDITOR'
alias nv='nvim'

alias grep='grep --color=auto'
alias diff='diff --color=auto'

alias mkdir='mkdir -pv'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -Iv'

alias please='sudo'
alias svim='sudo nvim'

alias gs='git status --short'
alias gst='git status'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias gds='git diff --staged'

alias hm='home-manager'
alias hms='home-manager switch'
alias hmb='home-manager build'

alias home-dirty='find "$HOME" -maxdepth 1 -mindepth 1 -printf "%f\n" | sort'
alias ports='ss -tulpn'
alias myip='ip addr'

# Prefer modern tools when available.
if command -v eza >/dev/null 2>&1; then
  alias tree='eza --tree'
  alias la='eza -la --group-directories-first'
  alias ll='eza -l --group-directories-first'
else
  alias la='ls -la'
  alias ll='ls -lh'
fi

if command -v bat >/dev/null 2>&1; then
  alias cat='bat'
fi




alias nv='nvim'
alias hm_update='home-manager switch --flake ~/.config/home-manager'
alias c='clear'
alias symconfig='$HOME/.local/scripts/move_and_link_arg.sh'
alias archivist='ssh archivist@192.168.50.52 -p 1623'
alias vps='ssh rule@85.31.224.222'
alias nvimconfig='cd $HOME/.config/nvim/lua/rule && nvim .'
alias zrc='nvim $HOME/.zshrc'
alias config='/usr/bin/git --git-dir=$HOME/.config/dotfiles --work-tree=$HOME' 
alias dwmconfig='nvim programs/dwm/config.h'
alias src='source venv/bin/activate'
alias cr='cargo run'
alias ct='cargo test -- --nocapture'
alias btfcr='RUST_BACKTRACE=full cargo run'
alias poafolder='cd $HOME/.local/share/Steam/steamapps/compatdata/2128270/pfx/drive_c/users/steamuser/AppData/Roaming/Godot/app_userdata/PoA'
alias mcbuild="/home/rule/.local/scripts/monkeyc_build.sh"
alias rli='ssh -i ~/.ssh/radiant-forge-poc-key.pem ec2-user@52.87.130.245'
alias rli_nv='nvim -i ~/.ssh/radiant-forge-poc-key.pem oil-ssh:44.202.3.58//ec2-user@//data/radiant/vds/vds_server' 
alias splunk_nv='nvim oil-ssh://adem@splunk//opt/splunk' 
