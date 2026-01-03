{
  pkgs,
  lib,
  inputs,
  config,
  settings,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
    # inputs.sops-nix.nixosModules.sops
    ./admin.nix
  ];
  boot.loader.grub.enable = lib.mkForce false;
  boot.loader.systemd-boot.enable = lib.mkForce false;
  services.openssh.enable = true;
  services.qemuGuest.enable = true;

}
