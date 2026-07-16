{ host, ... }:

# Shared Home Manager identity and machine metadata.
#
# `host` comes from extraSpecialArgs in lib/mk-home.nix. Adding a field to a
# host entry in hosts/default.nix makes it available here as host.<field>.
{
  home.username = host.user.name;
  home.homeDirectory = host.user.home;
  home.stateVersion = host.homeStateVersion;

  programs.home-manager.enable = true;

  # These variables let native application configs identify the current host
  # without converting those application configs into Nix modules.
  home.sessionVariables = {
    RULE_HOST = host.hostName;
    RULE_ROLE = host.role;
    NVIM_PROFILE = host.nvimProfile;
  };
}
