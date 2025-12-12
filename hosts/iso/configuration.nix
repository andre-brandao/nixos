{
  pkgs,
  lib,
  config,
  inputs,
  settings,
  ...
}:
{
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

    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    # extraOptions = "experimental-features = nix-command flakes";
  };

  services = {
    qemuGuest.enable = true;
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings.PermitRootLogin = lib.mkForce "yes";
      # authorizedKeysFiles = [ "/etc/ssh/authorized_keys" ];
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
  networking = {
    networkmanager.enable = true;
    # hostName = "iso";
  };

  environment.systemPackages = with pkgs; [
    wget
    curl
    rsync
    git
  ];

  programs.zsh.enable = true;
  users.users.${settings.username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [ ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCuQkJ02xZKVFiulDUVgtyOzR01L9aj0ydfivlJtuip81NqsfPhwWW4XyW6uLkkhmOsDUsr9ZhEzl4XsLRX2r8PZS03/XBLH/7Yft6P01ECxyCe9vnXZ8i8J3FJ141ZLQPXtNTqpRmPdPYbclDQASqnVu5UKfaBlWyheXni9R0bvPC1FqpozUh4+UVUMJT4dUkThSX+Ph5/czJAZkwzwsKrOn0A99qwX1wmFewh3UJ4QOpYgjE8QTyVdEUnDFdiB2vybrRjWD9kqROQslVG2CtYU+P2aDvLJa2Rdau/mTOyWM+Vn9a/dM55tDuwwD/VJWw97/f2f0YYXs+29OhTZXPKLRLGTURhQgOK6afX6x7EUsPJp+7n2D38FSqskgh4RxU7nf+Ja7YLsqaJCNdLj9yfvOBvBZdHpsf7yykSX9Fdkl9Dqrgg9e6HRmWK4cEULq5JObWyKnizHJEMXCJeGTWO3Z3hxh6fw6c84a6AD2PvckPxpUZpza2grNez+EonBuq0YKgARhv9ZpqOVoKJ6W9Xg7PYZRAOMsAgWFasLZQxgJtne7U4d/Tlp6xWeDr9DbTdqFTm+tsQEYynOb3EG3BsAdTrRunx5xrYPmtk4FYTC+ru6zBpq9yGwafhjwjd1G2YR3z6MToOUykC/veLi9L0uJKeHtw12qaEzs3ETn382Q== root@pve"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMieINuQUpTfgeZpfUYTpSO27FNJ/rMq08uxGKjW5Mv0 andre-brandao@github/98560022 # ssh-import-id gh:andre-brandao"
    ];
  };
  nix.settings.trusted-users = [ settings.username ];

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
