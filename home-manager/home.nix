

{ config, pkgs, ... }:

{
  home.username = "rule";
  home.homeDirectory = "/home/rule";
  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  imports = [
    ./modules/paths.nix
    ./modules/xdg-hygiene.nix
    ./modules/links.nix
  ];
home.file.".zshenv".text = ''
  if [ -e "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
    . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
  fi

  export ZDOTDIR="''${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
'';

}
