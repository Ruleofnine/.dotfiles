{ config, host, ... }:

let
  home = config.home.homeDirectory;
in
{
  home.sessionPath = [
    "${home}/.local/bin"
    "${home}/.local/scripts"

    # XDG-managed user tool bins
    "${config.xdg.dataHome}/cargo/bin"
    "${config.xdg.dataHome}/npm/bin"
    "${config.xdg.dataHome}/go/bin"

    # System / external tool paths
    "/opt/android-sdk/cmdline-tools/latest/bin"
    "/opt/android-sdk/platform-tools"
    "/opt/android-sdk/emulator"
    "/opt/sqlanywhere12/bin64"

    # Nix profile compatibility
    "${home}/.nix-profile/bin"

    # Garmin, currently still legacy/app-specific
    "${home}/.Garmin/ConnectIQ/Sdks/connectiq/bin"
  ];

  home.sessionVariables = {
    DOTFILES = host.user.dotfiles;
    EDITOR = "nvim";
    VISUAL = "nvim";

    SCRIPTS_DIR = "${home}/.local/scripts";
    CODEDIR = "${home}/coding";

    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";

    ANDROID_HOME = "/opt/android-sdk";
    SQLANY12 = "/opt/sqlanywhere12";
  };
}
