# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  pkgs-unstable,
  # userSettings,
  settings,
  ...
}:
{
  # You can import other NixOS modules here
  imports = [
    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    ../../nixos/config

    ../../nixos/virtualization.nix
    ../../nixos/docker.nix
    ../../nixos/gaming.nix

    ../../nixos/desktop/hyprland.nix

    # styles
    ../../nixos/style.nix

    ../../modules/nixos/nix.nix

  ];

  fonts.fontDir.enable = true;
  # USERS
  users.users.${settings.username} = {
    isNormalUser = true;
    # description = settings.name;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;

    packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.${settings.username} = import ./home.nix;
    extraSpecialArgs = {
      # inherit pkgs-unstable;
      inherit inputs outputs;
      inherit settings;
    };
  };

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs = {
    zsh.enable = true;
    nix-ld.enable = true;
  };
  environment.systemPackages = with pkgs; [
    # helix
    vim
    wget
    zsh
    git
    wireguard-tools
    protonvpn-gui
    # (callPackage ../../packages/duckling-appimage.nix)

  ];
  environment.pathsToLink = [ "/share/zsh" ];
  security.polkit.enable = true;

  # firmware updater
  services.fwupd.enable = true;
  services = {
    tailscale.enable = true;
    resolved = {
      enable = true;
      dnssec = "false";
    };
  };
  # cross compilation for aarch64
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  # fileSystems."/mnt/deds_drive" = {
  #   device = "truenas.fable-company.ts.net:/mnt/default/drives/deds";
  #   fsType = "nfs";
  #   options = [
  #     "x-systemd.automount"
  #     "noauto"
  #   ];
  # };
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
