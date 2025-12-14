{
  pkgs,
  lib,
  modulesPath,
  ...
}:
{
  imports = [
    # (modulesPath + "/profiles/qemu-guest.nix")
    ../../modules/nixos/pve-vm.nix
    "${toString modulesPath}/virtualisation/proxmox-image.nix"
  ];

  # # Use the boot drive for grub
  # boot.loader.grub.enable = lib.mkDefault true;
  # boot.loader.grub.devices = [ "nodev" ];
  proxmox.qemuConf.virtio0 = "local-zfs:vm-9999-disk-0";
  proxmox.cloudInit.defaultStorage = "local-zfs";

  fileSystems."/" = lib.mkDefault {
    device = "/dev/disk/by-label/nixos";
    autoResize = true;
    fsType = "ext4";
  };
  system.stateVersion = lib.mkDefault "25.11";
}
