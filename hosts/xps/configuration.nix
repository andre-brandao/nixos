# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  userSettings,

  ...
}:
{
  # You can import other NixOS modules here
  imports = [
    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    ../../system/config

    ../../system/app/virtualization.nix
    ../../system/app/docker.nix
    ../../system/app/gaming.nix

    ../../system/app/cross-compilation.nix
    ../../system/app/tailscale.nix

    ../../system/desktop/${userSettings.wm}.nix

    # styles
    ../../system/style/stylix.nix

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
      trusted-users = root ${userSettings.username}
    '';
  };

  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/path/${name}";
    value.source = value.flake;
  }) config.nix.registry;

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
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
          "postman"
          "stremio-shell"
          "stremio-server"
        ];

      permittedInsecurePackages = [
        "beekeeper-studio-5.1.5"
      ];
    };
  };

  fonts.fontDir.enable = true;
  # USERS
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;

    packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
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
    # (callPackage ../../packages/duckling-appimage.nix)

  ];
  environment.pathsToLink = [ "/share/zsh" ];
  security.polkit.enable = true;

  # firmware updater
  services.fwupd.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
