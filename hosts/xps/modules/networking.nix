{ settings, ... }:
{
  networking.hostName = settings.hostname;
  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  programs.kdeconnect.enable = true;
  networking.firewall.allowedTCPPortRanges = [
    #   # # KDE Connect
    #   {
    #     from = 1714;
    #     to = 1764;
    #   }
    # # Expo
    {
      from = 8080;
      to = 8081;
    }
  ];
  networking.firewall.allowedUDPPortRanges = [
    #   # # KDE Connect
    #   {
    #     from = 1714;
    #     to = 1764;
    #   }
    #   # # # Expo
    {
      from = 8080;
      to = 8081;
    }
  ];

}
