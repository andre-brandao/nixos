{
  pkgs,
  dconf,
  config,
  userSettings,
  ...
}:
{

  # --------
  # if you get an error about the user not being able to access the default libvirt network, run the following command:
  # sudo virsh net-start default
  # ---------

  users.users.${userSettings.username}.extraGroups = [ "libvirtd" ];
  environment.systemPackages = with pkgs; [
    virtualbox
    distrobox
    libvirt-glib
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [ virtualbox ];

  ## QEMU + VirtManager
  virtualisation.libvirtd.enable = true;
  # sudo virsh net-start default (RUN THIS IF NETWORK IS NOT STARTED)
  programs.virt-manager.enable = true;
}
