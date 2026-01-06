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
    ../../modules/nixos/core/config
    ../../modules/nixos/nix.nix
    ../../modules/nixos/style.nix
    ../../modules/nixos/gaming.nix
    ../../modules/nixos/programs/docker.nix
    ../../modules/nixos/programs/virtualization.nix
    ../../modules/nixos/desktop/hyprland.nix

  ];

  environment.systemPackages = with pkgs; [
    # helix
    vim
    wget
    zsh
    git
    wireguard-tools
    protonvpn-gui

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
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024; # 32GB in MB
    }
  ];
  boot.kernelParams = [
    "resume_offset=14204928"
    "mem_sleep_default=deep"
  ];

  boot.resumeDevice = "/dev/disk/by-uuid/4b1ea965-befe-439d-9e3d-d84bdc35bae0";

  powerManagement.enable = true;
  services.power-profiles-daemon.enable = true;
  # Suspend first then hibernate when closing the lid
  services.logind.lidSwitch = "suspend-then-hibernate";
  # Hibernate on power button pressed
  services.logind.powerKey = "hibernate";
  services.logind.powerKeyLongPress = "poweroff";
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30m
    SuspendState=mem
  '';
  # cross compilation for aarch64
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
