{pkgs, ...} :
{
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    curl
    htop
    tmux
    pciutils
    usbutils
    lsof
    nmap
    starship
    eza
    lua-language-server
    nil
    fff
    tree-sitter
    gcc
    gnumake
    zsh
    rustc
    cargo
    gcc
    pkg-config
  ];
}
