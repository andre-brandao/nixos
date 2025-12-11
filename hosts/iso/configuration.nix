{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  isoImage.squashfsCompression = "zstd -Xcompression-level 3";

  nixpkgs = {
    hostPlataform = lib.mkDefault "x86_64-linux";
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    # extraOptions = "experimental-features = nix-command flakes";
  };

  services = {
    qemuGuest.enable = true;
    openssh = {
      ports = [ 22 ];
      settings.PermitRootLogin = lib.mkForce "yes";
      # authorizedKeysFiles = [ "/etc/ssh/authorized_keys" ];
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    # supportedFilesystems = [
    #   "btrfs"
    #   "zfs"
    #   "ext4"
    #   "vfat"
    # ];
  };
  networking = {
    networkmanager.enable = true;
    # hostName = "iso";
  };
  # sytemd = {
  #   services.sshd.wantedBy = [ "multi-user.target" ];
  #   targets = {

  #   };
  # };
  environment.systemPackages = with pkgs; [
    wget
    curl
    rsync
    git
  ];

}
