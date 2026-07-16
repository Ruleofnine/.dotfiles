{ inputs }:

# Convert one entry from hosts/default.nix into a complete NixOS system.
host:
inputs.nixpkgs.lib.nixosSystem {
  system = host.system;

  # `specialArgs` makes these values available as module arguments:
  #
  #   { inputs, host, config, lib, pkgs, ... }:
  #
  # Add another project-wide custom module argument here only when it truly
  # needs to be available throughout the NixOS module graph.
  specialArgs = {
    inherit inputs host;
  };

  # All NixOS machines receive the shared module bundle first, plus the
  # machine-specific modules declared in that host's inventory record.
  modules = [
    ../modules/nixos
  ] ++ host.modules;
}
