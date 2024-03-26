{ pkgs, dconf, config, userSettings, ... }: {
  ## DOCKER
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  users.users.${userSettings.username}.extraGroups = [ "docker" ];
  # users.users.${userSettings.username}.extraGroups = [ "libvirtd" ];
  environment.systemPackages = with pkgs; [
    lazydocker
  ];
}
