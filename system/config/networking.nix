{ systemSettings, ... }:
{
  networking.hostName = systemSettings.hostname;
  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  # programs.kdeconnect.enable = true;
  networking.firewall.allowedTCPPortRanges = [
    # # KDE Connect
    # {
    #   from = 1714;
    #   to = 1764;
    # }
    {
      from = 8081;
      to = 8081;
    }
  ];
  networking.firewall.allowedUDPPortRanges = [
    # # KDE Connect
    # {
    #   from = 1714;
    #   to = 1764;
    # }
      {
      from = 8081;
      to = 8081;
    }
  ];
}
