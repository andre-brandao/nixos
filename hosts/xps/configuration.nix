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

  ];

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = (lib.mapAttrs (_: flake: { inherit flake; })) (
      (lib.filterAttrs (_: lib.isType "flake")) inputs
    );
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };

    extraOptions = ''
      trusted-users = root ${settings.username}
    '';
  };

  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/path/${name}";
    value.source = value.flake;
  }) config.nix.registry;

  nixpkgs = {
    # You can add overlays here
    overlays = builtins.attrValues outputs.overlays;
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = false;
      # Enable unfree packages you want to use
      allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "spotify"
          "steam-unwrapped"
          "steam"
          "discord"
          "obsidian"
        ];

      # permittedInsecurePackages = [
      #   "beekeeper-studio-5.1.5"
      # ];
    };
  };

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
