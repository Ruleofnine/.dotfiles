{ inputs }:

# Public builder interface used by outputs.nix.
#
# Keeping these constructors behind one attribute set makes outputs.nix depend
# on `builders.mkNixos` and `builders.mkHome`, rather than on their file paths.
{
  mkNixos = import ./mk-nixos.nix { inherit inputs; };
  mkHome = import ./mk-home.nix { inherit inputs; };
}
