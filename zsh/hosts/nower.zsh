# ~/.config/zsh/hosts/nower.zsh

export RULE_ROLE="server"
export RULE_HOST="nower"

# No fastfetch by default on server SSH.
# Keep login clean and useful.

alias dots='cd ~/.dotfiles'
alias srv='cd /srv'
alias logs='journalctl -xe'
alias ports='ss -tulpn'
alias services='systemctl --type=service --state=running'
alias failed='systemctl --failed'
alias timers='systemctl list-timers'

# NixOS server workflow.
alias rebuild='sudo nixos-rebuild switch'
alias rebuild-test='sudo nixos-rebuild test'
alias nixconf='cd /etc/nixos'
alias nixgc='sudo nix-collect-garbage -d'

# Lab services.
alias adguard-logs='journalctl -u adguardhome -f'
alias cups-logs='journalctl -u cups -f'
alias printers='lpstat -v && lpstat -p'
