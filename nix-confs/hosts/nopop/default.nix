{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./packages.nix
    ./users.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # KDE Plasma
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Keyboard
  hardware.keyboard.zsa.enable = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Audio
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printing
  services.printing.enable = true;

  # Remote access
  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  # Regional settings
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # Required for proprietary packages such as Steam and Discord.
  nixpkgs.config.allowUnfree = true;

  # Keep this at the original installation version.
  system.stateVersion = "25.11";
}
