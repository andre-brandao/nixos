{
  pkgs,
  lib,
  inputs,
  outputs,
  settings,
  ...
}:

{
  imports =
    map lib.custom.relativeToNixOSModules [
      "pve-vm.nix"
      "nix.nix"
      "style.nix"
    ]
    ++ lib.custom.scanPaths ./modules;

  environment.systemPackages = [
    pkgs.helix
  ];

  networking.hostName = "git";

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
