{ pkgs, ...  }:
{
services.printing = {
  enable = true;
  drivers = with pkgs; [
    brlaser
    gutenprint
  ];

  browsing = true;
  defaultShared = true;
  openFirewall = true;
  listenAddresses = [ "*:631" ];
  allowFrom = [ "all" ];
};
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };


}
