{ pkgs, ... }:

{
  programs.firefox.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    # Core tools
    git
    wget
    unzip

    # Terminal and desktop tools
    foot
    remmina
    flameshot
    keymapp

    # Security and networking
    nmap
    burpsuite

    # Applications
    obsidian
    discord
    zoom

    # Documents and writing
    typst
    tinymist

    # Gaming
    prismlauncher
  ];
}
