{ config, ... }:

let
  link = config.lib.file.mkOutOfStoreSymlink;
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
in
{
  xdg.configFile."zsh".source =
    link "${dotfiles}/zsh";

  xdg.configFile."nvim".source =
    link "${dotfiles}/nvim";

  xdg.configFile."starship.toml".source =
    link "${dotfiles}/starship/starship.toml";
}
