{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zsh-syntax-highlighting
    starship
  ];
}
