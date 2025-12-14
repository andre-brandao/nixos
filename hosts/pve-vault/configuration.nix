{
  pkgs,
  lib,
  modulesPath,
  settings,
  ...
}:

{
  imports = [
    ../../modules/nixos/pve-vm.nix
    ./vaultwarden.nix
    ./disko.nix
    ./sops.nix
  ];
  environment.systemPackages = [
    pkgs.helix
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.${settings.username} = ./home.nix;
    backupFileExtension = "backup";
  };
  programs.zsh.enable = true;

  system.stateVersion = "25.11";
}
