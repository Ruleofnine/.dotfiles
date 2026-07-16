# nix-confs

Declarative configuration for Rule's NixOS and standalone Home Manager systems.
The repository is designed to stay explicit: the flake has a thin entry point,
the machine inventory says which configurations exist, builders turn inventory
records into complete configurations, and modules contain the actual settings.

## Repository layout

```text
.
├── flake.nix                 # Declares inputs and delegates output construction
├── outputs.nix               # Turns the host inventory into flake outputs
├── hosts/
│   ├── default.nix           # Explicit inventory of deployable configurations
│   ├── arbacus/              # Arbacus-only Home Manager modules
│   └── nower/                # Nower-only NixOS modules
├── lib/
│   ├── default.nix           # Public builder interface
│   ├── mk-home.nix           # Builds one standalone Home Manager configuration
│   └── mk-nixos.nix          # Builds one NixOS configuration
├── modules/
│   ├── home/                 # Shared Home Manager modules
│   └── nixos/                # Shared NixOS modules
└── users/                    # Reusable user records
```

The main separation is:

- `hosts/default.nix` declares **what configurations exist** and their metadata.
- `hosts/<name>/` contains settings that belong to only one machine.
- `modules/home/` and `modules/nixos/` contain settings shared by a class of machines.
- `lib/` contains the construction logic that connects inventory records to NixOS or Home Manager.
- Native application configurations remain native files where practical; Nix supplies the machine and environment orchestration around them.

## Overall execution flow

### 1. The flake loads its inputs

`flake.nix` declares `nixpkgs` and Home Manager, then delegates output creation:

```nix
outputs = inputs: import ./outputs.nix { inherit inputs; };
```

At this point, `outputs.nix` receives the complete flake input set as `inputs`.

### 2. `outputs.nix` loads the inventory and builders

```nix
builders = import ./lib { inherit inputs; };
hostInventory = import ./hosts;
```

These evaluate to two ordinary attribute sets:

```nix
builders = {
  mkNixos = /* function */;
  mkHome = /* function */;
};

hostInventory = {
  nixos = {
    nower = /* host definition */;
  };

  home = {
    arbacus = /* host definition */;
  };
};
```

### 3. `mapAttrs` transforms each inventory entry

The output definitions are intentionally written with named callbacks:

```nix
nixosConfigurations =
  nixpkgs.lib.mapAttrs buildNixosConfiguration hostInventory.nixos;

homeConfigurations =
  nixpkgs.lib.mapAttrs buildHomeConfiguration hostInventory.home;
```

`mapAttrs` preserves every attribute name and transforms its value. Conceptually:

```text
hostInventory.nixos.nower
    raw host definition
          │
          ▼ builders.mkNixos
nixosConfigurations.nower
    complete NixOS configuration
```

For the Home Manager side:

```text
hostInventory.home.arbacus
    raw host definition
          │
          ▼ builders.mkHome
homeConfigurations.arbacus
    complete Home Manager configuration
```

The callback receives both the entry name and value because that is the interface
of `mapAttrs`. The name is currently unused, so it is written with a leading
underscore:

```nix
buildNixosConfiguration =
  _configurationName:
  hostDefinition:
  builders.mkNixos hostDefinition;
```

The longer version above is equivalent to the compact expression:

```nix
nixpkgs.lib.mapAttrs (_: host: builders.mkNixos host) hostInventory.nixos
```

The named version is used so the main output declarations remain easy to read.

### 4. A builder creates the complete configuration

For NixOS, `lib/mk-nixos.nix` calls `nixpkgs.lib.nixosSystem`. It supplies:

- the host's target system architecture;
- `inputs` and the current `host` as custom module arguments;
- the shared NixOS module bundle;
- that machine's own modules from `host.modules`.

For standalone Home Manager, `lib/mk-home.nix` performs the corresponding work
with `home-manager.lib.homeManagerConfiguration`.

### 5. The module system evaluates shared and machine-specific modules

The builders make the inventory record available as the `host` module argument.
A module can therefore declare:

```nix
{ host, config, lib, pkgs, ... }:

{
  # host.hostName, host.role, host.user, and other inventory fields are available.
}
```

Shared base modules consume common metadata such as the hostname, user, role,
time zone, and Neovim profile. Host directories then add settings unique to the
machine.

### 6. The flake selector chooses one finished output

```sh
sudo nixos-rebuild switch --flake ~/.dotfiles/nix-confs#nower
```

selects:

```nix
nixosConfigurations.nower
```

Likewise:

```sh
home-manager switch --flake ~/.dotfiles/nix-confs#arbacus
```

selects:

```nix
homeConfigurations.arbacus
```

## Common commands

Format the repository:

```sh
nix fmt
```

Inspect the available flake outputs:

```sh
nix flake show
```

Build and activate Arbacus Home Manager:

```sh
home-manager switch --flake ~/.dotfiles/nix-confs#arbacus
```

Build and activate Nower:

```sh
sudo nixos-rebuild switch --flake ~/.dotfiles/nix-confs#nower
```

Build without activating when testing a change:

```sh
home-manager build --flake ~/.dotfiles/nix-confs#arbacus
sudo nixos-rebuild build --flake ~/.dotfiles/nix-confs#nower
```

## Adding another NixOS machine

1. Create `hosts/<hostname>/default.nix`.
2. Add the generated hardware configuration and any machine-specific modules.
3. Add an entry under `nixos` in `hosts/default.nix`.
4. Build it with the inventory attribute name as the flake selector.

Example inventory entry:

```nix
nixos = {
  laptop = {
    system = "x86_64-linux";
    hostName = "laptop";
    role = "laptop";
    nvimProfile = "desktop";
    timeZone = "America/New_York";
    user = rule;

    modules = [
      ./laptop
    ];
  };
};
```

Then build it with:

```sh
sudo nixos-rebuild build --flake .#laptop
```

No change to `outputs.nix` is necessary. `mapAttrs` automatically creates
`nixosConfigurations.laptop` from the new inventory entry.

## Adding another standalone Home Manager machine

1. Create `hosts/<hostname>/default.nix`.
2. Add an entry under `home` in `hosts/default.nix`.
3. Put only that machine's imports and settings in its host directory.
4. Build it with the inventory attribute name as the flake selector.

Example:

```nix
home = {
  work-laptop = {
    system = "x86_64-linux";
    hostName = "work-laptop";
    role = "laptop";
    nvimProfile = "desktop";
    homeStateVersion = "23.11";
    user = rule;

    modules = [
      ./work-laptop
    ];
  };
};
```

Then build it with:

```sh
home-manager build --flake .#work-laptop
```

## Adding shared behavior

Use the narrowest appropriate layer:

- Every standalone Home Manager machine: add or import a module from `modules/home/`.
- Every NixOS machine: add or import a module from `modules/nixos/`.
- One machine only: add it under `hosts/<name>/`.
- Reusable machine metadata: add a field to the inventory record and consume it through `host.<field>`.
- New construction behavior needed by all machines of one type: change the relevant builder under `lib/`.

For example, a new shared Home Manager module can be created at:

```text
modules/home/git.nix
```

and added to `modules/home/default.nix`:

```nix
{
  imports = [
    ./base.nix
    ./git.nix
    # ...existing modules
  ];
}
```

## Design rules

- Keep `flake.nix` a small entry point.
- Keep the machine inventory explicit rather than discovering folders magically.
- Prefer named intermediate functions when the compact functional form hides intent.
- Put shared policy in shared modules and machine facts in host modules.
- Pass one structured `host` record instead of many unrelated custom arguments.
- Use standard module arguments such as `config`, `lib`, and `pkgs` directly.
- Keep substantial application configurations in their native formats when that preserves portability and readability.
- Do not commit generated `result` or `result-*` build outputs.
