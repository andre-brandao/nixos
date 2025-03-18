# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{
  config,
  lib,
  pkgs,
  inputs,
  userSettings,
  ...
}:

{

  imports = [
    # <nixos-wsl/modules> # include NixOS-WSL modules
    inputs.nixos-wsl.nixosModules.default

    ../../system/cachix.nix
   ../../system/style/stylix.nix
    # styles
    # ../../system/style/stylix.nix
    (fetchTarball {
      url = "https://github.com/nix-community/nixos-vscode-server/tarball/master";
      sha256 = "09j4kvsxw1d5dvnhbsgih0icbrxqv90nzf0b589rb5z6gnzwjnqf";

    })
  ];

  services.vscode-server.enable = true;

  programs.nix-ld = {
      enable = true;
      # package = pkgs.nix-ld-rs; # only for NixOS 24.05
  };

  wsl.enable = true;
  wsl.defaultUser = userSettings.username;

  environment.systemPackages = with pkgs; [
    # helix
    vim
    wget
    zsh
    git
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
