{
  pkgs,
  dconf,
  config,
  settings,
  ...
}:
{
  ## DOCKER
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    # rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    # };
  };
  users.users.${settings.username}.extraGroups = [ "docker" ];
  # users.users.${userSettings.username}.extraGroups = [ "libvirtd" ];
  environment.systemPackages = with pkgs; [ lazydocker ];
}
