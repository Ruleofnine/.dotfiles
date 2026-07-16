{ host, ... }:

{
  users.users.${host.user.name} = {
    isNormalUser = true;
    description = host.user.description;
    home = host.user.home;
    extraGroups = [
      "wheel"
      "networkmanager"
      "lpadmin"
    ];

    # Replace this with an SSH key or a hashed password file.
    initialPassword = "changeme";
  };

  security.sudo.wheelNeedsPassword = true;
}
