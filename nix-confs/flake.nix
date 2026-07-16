{
  description = "Rule's systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";

    };

  };

  outputs = inputs: import ./outputs.nix { inherit inputs; };
}
