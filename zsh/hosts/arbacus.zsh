# ~/.config/zsh/hosts/arbacus.zsh

export RULE_ROLE="desktop"
export RULE_HOST="arbacus"

# Desktop greeting only for local terminals.
if [[ -z "${SSH_CONNECTION:-}" ]] && command -v fastfetch >/dev/null 2>&1; then
  fastfetch
fi

# Desktop-specific aliases.
alias dots='cd ~/.dotfiles'
alias hmconf='cd ~/.dotfiles/home-manager'
alias code='cd ~/coding'
alias dl='cd ~/Downloads'
alias pics='cd ~/Pictures'

# Arch/Home Manager workflow.
alias pacs='pacman -Qqe'
alias pacaur='pacman -Qqm'
alias pacorphans='pacman -Qtdq'
alias pacclean='sudo pacman -Rns $(pacman -Qtdq)'

# Lab shortcuts.
alias nower='ssh nower.home.arpa'
alias optrider='ssh root@10.20.0.1'
alias broter-status='lpstat -h 10.20.0.10:631/version=1.1 -p Broter -l'

# Work / RPS shortcuts.
alias rps='cd ~/coding/rupus'
