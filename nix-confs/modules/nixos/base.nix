{ host, ... }:

# Shared NixOS settings derived from the machine inventory.
#
# `host` comes from specialArgs in lib/mk-nixos.nix. Add values here when every
# NixOS machine should consume the same inventory field in the same way.
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  networking.hostName = host.hostName;
  time.timeZone = host.timeZone;

  # Native application configs can use these variables without being rewritten
  # as Nix modules.
  environment.sessionVariables = {
    RULE_HOST = host.hostName;
    RULE_ROLE = host.role;
    NVIM_PROFILE = host.nvimProfile;
  };
}
