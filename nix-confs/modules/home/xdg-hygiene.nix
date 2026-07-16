{ config, ... }:

let
  home = config.home.homeDirectory;
  cfg = config.xdg.configHome;
  data = config.xdg.dataHome;
  cache = config.xdg.cacheHome;
  state = "${home}/.local/state";
in
{
  xdg.enable = true;

  home.sessionVariables = {
    XDG_CONFIG_HOME = cfg;
    XDG_DATA_HOME = data;
    XDG_CACHE_HOME = cache;
    XDG_STATE_HOME = state;

    # Language/tool ecosystems
    CARGO_HOME = "${data}/cargo";
    RUSTUP_HOME = "${data}/rustup";
    GOPATH = "${data}/go";
    PUB_CACHE = "${data}/pub-cache";
    GRADLE_USER_HOME = "${data}/gradle";

    # npm
    NPM_CONFIG_USERCONFIG = "${cfg}/npm/npmrc";
    NPM_CONFIG_CACHE = "${cache}/npm";
    NPM_CONFIG_PREFIX = "${data}/npm";

    # AWS
    AWS_CONFIG_FILE = "${cfg}/aws/config";
    AWS_SHARED_CREDENTIALS_FILE = "${cfg}/aws/credentials";

    # Terraform
    TF_CLI_CONFIG_FILE = "${cfg}/terraform/terraform.tfrc";
    TF_PLUGIN_CACHE_DIR = "${cache}/terraform/plugin-cache";

    # Misc app cleanup
    WINEPREFIX = "${data}/wine/default";
    OLLAMA_MODELS = "${data}/ollama/models";

    # Histories/state
    LESSHISTFILE = "${state}/less/history";

    # Kubernetes
    KUBECONFIG = "${config.xdg.configHome}/kube/config";

    # ODBC - careful because your Sybase/ODBC setup depends on this
    ODBCINI = "${config.xdg.configHome}/odbc/odbc.ini";

    # Electron native build cache
    npm_config_devdir = "${config.xdg.cacheHome}/electron-gyp";

    # X11 auth file, for legacy X/XWayland stuff
    XAUTHORITY = "${config.home.homeDirectory}/.local/state/x11/Xauthority";

  };

  xdg.configFile."home-hygiene/allowlist".text = ''
    .cache
    .config
    .dotfiles
    .local
    .ssh
    .gnupg
    .nix-profile
    .nix-channels
    .nix-defexpr
    .zshenv
    .var
    .cups
    .gvfs
  '';

  home.file.".local/bin/home-audit" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      allow="$HOME/.config/home-hygiene/allowlist"

      find "$HOME" -maxdepth 1 -mindepth 1 -printf '%f\n' \
        | sort \
        | grep '^\.' \
        | grep -vxFf "$allow" || true
    '';
  };

  home.file.".local/bin/home-audit-real" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      allow="$HOME/.config/home-hygiene/allowlist"

      find "$HOME" -maxdepth 1 -mindepth 1 ! -type l -printf '%f\n' \
        | sort \
        | grep '^\.' \
        | grep -vxFf "$allow" || true
    '';
  };

  home.file.".local/bin/home-exile" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      name="''${1:?usage: home-exile .thing}"
      src="$HOME/$name"
      clean="''${name#.}"
      dst="$HOME/.local/share/home-exile/$clean"

      if [[ ! -e "$src" && ! -L "$src" ]]; then
        echo "No such file or symlink: $src" >&2
        exit 1
      fi

      if [[ -L "$src" ]]; then
        echo "$src is already a symlink:"
        readlink "$src"
        exit 0
      fi

      mkdir -p "$HOME/.local/share/home-exile"
      mv "$src" "$dst"
      ln -s "$dst" "$src"
      echo "$src -> $dst"
    '';
  };
}
