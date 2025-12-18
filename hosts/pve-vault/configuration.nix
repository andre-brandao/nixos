{
  pkgs,
  lib,
  inputs,
  outputs,
  settings,
  ...
}:

{
  imports = [
    ../../modules/nixos/pve-vm.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/style.nix
    ./containers/vaultwarden.nix
    ./containers/traefik.nix
    ./containers/vault.nix
    ./containers/podman.nix
    ./disko.nix
    ./sops.nix
  ];
  environment.systemPackages = [
    pkgs.helix
  ];

  networking.hostName = "vault";

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.${settings.username} = ./home.nix;
    backupFileExtension = "backup";
    extraSpecialArgs = {
      # inherit pkgs-unstable;
      inherit inputs outputs;
      inherit settings;
    };
  };
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  environment.pathsToLink = [ "/share/zsh" ];

  services = {
    tailscale.enable = true;
    resolved = {
      enable = true;
      dnssec = "false";
    };
  };

  system.stateVersion = "25.11";
}
