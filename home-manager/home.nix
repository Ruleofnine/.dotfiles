{ config, pkgs, ... }:

let
  mkLink = config.lib.file.mkOutOfStoreSymlink;
  # root of your dotfiles repo
  dot = "${config.home.homeDirectory}/.dotfiles";
in
{
  home.username = "rule";
  home.homeDirectory = "/home/rule";
  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  xdg.enable = true;

  # --- PATH ---
  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.xdg.dataHome}/cargo/bin"
    "/opt/android-sdk/cmdline-tools/latest/bin"
    "/opt/android-sdk/platform-tools"
    "/opt/android-sdk/emulator"
    "${config.home.homeDirectory}/.nix-profile/bin"
    "${config.home.homeDirectory}/.Garmin/ConnectIQ/Sdks/connectiq/bin"
  ];
  # --- session env ---
  home.sessionVariables = {
    ZDOTDIR = "${config.home.homeDirectory}/.config/zsh";
    DOTFILES = "${dot}";
    EDITOR = "nvim";
    ANDROID_HOME = "/opt/android-sdk";
    SCRIPTS_DIR = "${config.home.homeDirectory}/.local/scripts";
    CODEDIR = "${config.home.homeDirectory}/coding";
    PUB_CACHE = "${config.xdg.dataHome}/pub-cache";
    GOPATH = "${config.xdg.dataHome}/go";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
  };
 #-- NEEDED SO THE .ZPROFILE will source our session varibales
 home.file.".zshenv".text = ''
  export ZDOTDIR="$HOME/.config/zsh"
  export PATH="/home/rule/.local/bin:$PATH"
  '';

  # --- map repo configs into ~/.config ---
  # folders -> folders
  xdg.configFile."alacritty".source = mkLink "${dot}/alacritty";
  xdg.configFile."foot".source      = mkLink "${dot}/foot";
  xdg.configFile."nvim".source      = mkLink "${dot}/nvim";
  xdg.configFile."waybar".source    = mkLink "${dot}/waybar";
  xdg.configFile."zsh".source       = mkLink "${dot}/zsh";
  xdg.configFile."hypr"             = {
    source = mkLink "${dot}/hypr";
    recursive = true;
  };
  xdg.configFile."fastfetch".source  = mkLink "${dot}/fastfetch";
  xdg.configFile."neofetch".source  = mkLink "${dot}/neofetch";
  home.file.".xinitrc".source       = mkLink "${dot}/.xinitrc";
}

