{ ... }:

{
  users.users.adem = {
    isNormalUser = true;
    description = "Adem";

    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
