{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./users.nix
    ./packages.nix
    ./storage.nix

    ../../modules/nixos/services/adguard-home.nix
    ../../modules/nixos/services/printer.nix
    ../../modules/nixos/services/postgresql.nix

    ./pg.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "26.05";
}
