{ config, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    history = {
      path = "${config.home.homeDirectory}/.local/state/zsh/history";
      size = 100000;
      save = 100000;
    };

    initExtraFirst = ''
      mkdir -p "$XDG_CACHE_HOME/zsh" "$XDG_STATE_HOME/zsh"
      autoload -Uz compinit
      compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"
    '';
  };
}
