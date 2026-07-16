{ config, ... }:

let
  link = config.lib.file.mkOutOfStoreSymlink;
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
in
{
  xdg.configFile."fastfetch".source = link "${dotfiles}/fastfetch";

  xdg.configFile."foot".source = link "${dotfiles}/foot";

  xdg.configFile."waybar".source = link "${dotfiles}/waybar";

  xdg.configFile."hypr" = {
    source = link "${dotfiles}/hypr";
    recursive = true;
  };

  xdg.configFile."alacritty".source = link "${dotfiles}/alacritty";

  xdg.configFile."terraform".source = link "${dotfiles}/terraform";
}
