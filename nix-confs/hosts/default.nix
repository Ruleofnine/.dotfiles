# Explicit machine inventory.
#
# A directory under hosts/ does not become a flake output automatically. Add an
# entry here to declare the machine and point its `modules` list at that folder.
#
# The attribute name becomes the flake selector:
#   nixos.<name> -> sudo nixos-rebuild switch --flake .#<name>
#   home.<name>  -> home-manager switch --flake .#<name>
#
# Every field in a host definition is available to modules through the custom
# `host` module argument. Shared modules use values such as host.hostName,
# host.role, host.user, and host.nvimProfile.
let
  rule = import ../users/rule.nix;
in
{
  nixos = {
    nower = {
      system = "x86_64-linux";
      hostName = "nower";
      role = "server";
      nvimProfile = "server";
      timeZone = "America/New_York";
      user = rule;

      # Machine-specific NixOS modules. The directory's default.nix is imported
      # when a directory path is placed in a module list.
      modules = [
        ./nower
      ];
    };

    # To add another NixOS machine:
    #
    # laptop = {
    #   system = "x86_64-linux";
    #   hostName = "laptop";
    #   role = "laptop";
    #   nvimProfile = "desktop";
    #   timeZone = "America/New_York";
    #   user = rule;
    #   modules = [ ./laptop ];
    # };

    nopop = {
      system = "x86_64-linux";
      hostName = "nopop";
      role = "laptop";
      nvimProfile = "desktop";
      timeZone = "America/New_York";
      user = rule;
      modules = [ ./nopop ];
    };
  };

  home = {
    arbacus = {
      system = "x86_64-linux";
      hostName = "arbacus";
      role = "desktop";
      nvimProfile = "desktop";
      homeStateVersion = "23.11";
      user = rule;

      # Machine-specific standalone Home Manager modules.
      modules = [
        ./arbacus
      ];
    };

    # To add another standalone Home Manager machine:
    #
    # work-laptop = {
    #   system = "x86_64-linux";
    #   hostName = "work-laptop";
    #   role = "laptop";
    #   nvimProfile = "desktop";
    #   homeStateVersion = "23.11";
    #   user = rule;
    #   modules = [ ./work-laptop ];
    # };
  };
}
