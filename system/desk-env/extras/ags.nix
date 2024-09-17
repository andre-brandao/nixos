{ ... }:
{
  services = {
    # AGS services
    upower = {
      enable = true;
      # useDeviceKit = true;
    };
    gvfs.enable = true;
    accounts-daemon.enable = true;
    devmon.enable = true;
    udisks2.enable = true;

    power-profiles-daemon.enable = true;
    gnome = {
      evolution-data-server.enable = true;
      glib-networking.enable = true;
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
      tracker-miners.enable = true;
      tracker.enable = false;
    };

  };
}
