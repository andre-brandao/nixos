{ pkgs, modulesPath, ... }:

{
  imports = [
    ./gitea.nix
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  services.tailscale.enable = true;

  environment.systemPackages = [
    pkgs.vim
  ];
}
