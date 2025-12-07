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
    # libvirt-glib
    # quickemu
  ];

  boot.extraModulePackages = [ config.boot.kernelPackages.virtualbox ];
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "andre" ];

  ## QEMU + VirtManager
  virtualisation.libvirtd = {
    enable = true;
    allowedBridges = [
      "nm-bridge"
      "virbr0"
    ];
    qemu = {
      runAsRoot = false;
      swtpm.enable = true;
    };

  };
  programs.virt-manager.enable = true;
}
