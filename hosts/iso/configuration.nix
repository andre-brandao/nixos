{
  pkgs,
  lib,
  config,
  inputs,
  settings,
  ...
}:
{
  imports = [
    ../../modules/nixos/pve-vm.nix
  ];
  isoImage.squashfsCompression = "zstd -Xcompression-level 3";

  nixpkgs = {
    # hostPlataform = lib.mkDefault "x86_64-linux";
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings.experimental-features = "nix-command flakes";
  };

  services = {
    openssh = {
      settings.PermitRootLogin = lib.mkForce "yes";
    };
  };

  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;
    # supportedFilesystems = [
    #   "btrfs"
    #   "zfs"
    #   "ext4"
    #   "vfat"
    # ];
  };

  environment.systemPackages = with pkgs; [
    wget
    curl
    rsync
    git
  ];

  security.sudo.extraRules = [
    {
      users = [ settings.username ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
