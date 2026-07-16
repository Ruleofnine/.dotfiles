{ inputs }:

let
  inherit (inputs) nixpkgs;

  # Builders turn one host inventory record into a complete configuration.
  builders = import ./lib { inherit inputs; };

  # This is the explicit inventory from hosts/default.nix.
  # Each attribute name becomes a flake selector, such as .#nower or .#arbacus.
  hostInventory = import ./hosts;

  # mapAttrs calls this function once for every entry in hostInventory.nixos.
  #
  # It supplies:
  #   1. the configuration name, such as "nower"
  #   2. that configuration's host definition
  #
  # mapAttrs preserves the configuration name automatically, so this callback
  # only needs to transform the host definition into a NixOS configuration.
  buildNixosConfiguration =
    _configurationName:
    hostDefinition:
    builders.mkNixos hostDefinition;

  # This is the Home Manager equivalent of buildNixosConfiguration above.
  # The leading underscore documents that the configuration name is supplied
  # by mapAttrs but intentionally unused by this callback.
  buildHomeConfiguration =
    _configurationName:
    hostDefinition:
    builders.mkHome hostDefinition;
in
{
  # Example result:
  #   hostInventory.nixos.nower
  #     -> nixosConfigurations.nower
  nixosConfigurations =
    nixpkgs.lib.mapAttrs buildNixosConfiguration hostInventory.nixos;

  # Example result:
  #   hostInventory.home.arbacus
  #     -> homeConfigurations.arbacus
  homeConfigurations =
    nixpkgs.lib.mapAttrs buildHomeConfiguration hostInventory.home;

  # Enables `nix fmt` for this flake on x86_64 Linux systems.
  formatter.x86_64-linux =
    nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
}
