{
  pkgs,
  dconf,
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
  ];

  ## QEMU + VirtManager
  virtualisation.libvirtd.enable = true;
  # sudo virsh net-start default (RUN THIS IF NETWORK IS NOT STARTED)
  programs.virt-manager.enable = true;
  # virt-manager + qemu config (virtual machines)
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
