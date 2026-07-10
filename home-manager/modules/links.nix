{ config, ... }:

let
  mkLink = config.lib.file.mkOutOfStoreSymlink;
  dot = "${config.home.homeDirectory}/.dotfiles";
in
{
  xdg.configFile."alacritty".source = mkLink "${dot}/alacritty";
  xdg.configFile."foot".source = mkLink "${dot}/foot";
  xdg.configFile."nvim".source = mkLink "${dot}/nvim";
  xdg.configFile."waybar".source = mkLink "${dot}/waybar";
  xdg.configFile."zsh".source = mkLink "${dot}/zsh";
  xdg.configFile."fastfetch".source = mkLink "${dot}/fastfetch";
  xdg.configFile."neofetch".source = mkLink "${dot}/neofetch";

  xdg.configFile."hypr" = {
    source = mkLink "${dot}/hypr";
    recursive = true;
  };

  home.file.".xinitrc".source = mkLink "${dot}/.xinitrc";
}
