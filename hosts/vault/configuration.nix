{
  pkgs,
  lib,
  modulesPath,
  settings,
  ...
}:

{
  imports = [
    ../../modules/nixos/pve-lxc.nix
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
