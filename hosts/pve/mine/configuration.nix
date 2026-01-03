{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ./mine.nix
    ../../modules/nixos/pve-vm.nix
    ../../modules/nixos/nix.nix
    # ../../modules/nixos/style.nix
    ./disko.nix
    ./sops.nix
    ./traefik.nix
    ./cloudflared.nix
  ];
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
