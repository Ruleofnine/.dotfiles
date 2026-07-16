{ host, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.starship.enable = true;

  users.users.${host.user.name}.shell = pkgs.zsh;
}
