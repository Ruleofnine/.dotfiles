{
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  networking.firewall.allowedTCPPorts = [
    22
    53    # DNS over TCP
    3000  # AdGuard initial/admin web UI
    8080  # Admin web UI port if you choose it
    3001  # AdGuard admin web UI
  ];

  networking.firewall.allowedUDPPorts = [
    53
  ];
}
