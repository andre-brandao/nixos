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
    virt-manager
    distrobox
    libvirt-glib
  ];

  boot.extraModulePackages = [ config.boot.kernelPackages.virtualbox ];

  ## QEMU + VirtManager
  virtualisation.libvirtd = {
    enable = true;
    qemu.runAsRoot = false;
    allowedBridges = [
      "nm-bridge"
      "virbr0"
    ];
  };
  programs.virt-manager.enable = true;
}
