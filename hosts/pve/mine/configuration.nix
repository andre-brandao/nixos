{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ./disko.nix
    ./sops.nix
  ]
  ++ map lib.custom.relativeToNixOSModules [
    "pve-vm.nix"
    "nix.nix"
    # "style.nix"
  ]
  ++ lib.custom.scanPaths ./services;

  environment.systemPackages = with pkgs; [
    vim
    git
    htop
    tmux
    helix
    # docker
    # docker-compose
  ];

  services = {
    tailscale.enable = true;
    resolved = {
      enable = true;
      dnssec = "false";
    };
  };

  networking.hostName = "mine";

}
