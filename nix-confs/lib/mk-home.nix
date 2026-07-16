{ inputs }:

# Convert one entry from hosts/default.nix into a standalone Home Manager
# configuration.
host:
inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = import inputs.nixpkgs {
    system = host.system;
    config.allowUnfree = true;
  };

  # Home Manager's equivalent of NixOS specialArgs. These values become module
  # arguments alongside config, lib, pkgs, and the standard module arguments.
  extraSpecialArgs = {
    inherit inputs host;
  };

  # All standalone Home Manager machines receive the shared home module bundle
  # plus the machine-specific modules declared in their inventory record.
  modules = [
    ../modules/home
  ] ++ host.modules;
}
