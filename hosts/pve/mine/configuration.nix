{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports =
    map lib.custom.relativeToNixOSModules [
      "pve-vm.nix"
      "nix.nix"
      # "style.nix"
    ]
    ++ lib.custom.scanPaths ./modules;

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
