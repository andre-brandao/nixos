{
  pkgs,
  dconf,
  config,
  ...
}: {
  ## DOCKER
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  # users.users.${userSettings.username}.extraGroups = [ "docker" ];
  # users.users.${userSettings.username}.extraGroups = [ "libvirtd" ];
  environment.systemPackages = with pkgs; [
    lazydocker
    virt-manager
    virtualbox
    distrobox
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [virtualbox];

  ## QEMU + VirtManager
  virtualisation.libvirtd.enable = true;
  # sudo virsh net-start default (RUN THIS IF NETWORK IS NOT STARTED)
  programs.virt-manager.enable = true;
}
