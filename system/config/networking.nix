{ systemSettings, ... }: {
  networking.hostName = systemSettings.hostname;
  # Enable networking
  networking.networkmanager.enable = true;

  networking.firewall.allowedTCPPortRanges = [
    # KDE Connect
    {
      from = 1714;
      to = 1764;
    }
  ];
  networking.firewall.allowedUDPPortRanges = [
    # KDE Connect
    {
      from = 1714;
      to = 1764;
    }
  ];
}
