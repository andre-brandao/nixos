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
    power-profiles-daemon.enable = true;

  };
}
