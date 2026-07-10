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
    ./modules/zsh.nix
  ];
}

