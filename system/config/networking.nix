{systemSettings, ...}: {
  networking.hostName = systemSettings.hostname;
  # Enable networking
  networking.networkmanager.enable = true;
}
