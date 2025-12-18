{
  pkgs,
  lib,
  inputs,
  config,
  settings,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
  ];
  networking = {
    networkmanager.enable = true;
  };

  # Use the boot drive for grub
  # boot.loader.grub.enable = lib.mkDefault true;
  # boot.loader.grub.devices = [ "nodev" ];
  # boot.growPartition = lib.mkDefault true;

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  boot.loader.efi.canTouchEfiVariables = false; # For VMs without EFI vars (Proxmox default)

  programs.zsh.enable = true;
  users.users.${settings.username} = {
    isNormalUser = true;
    # hashedPasswordFile = config.sops.secrets.password.path;
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
  nix.settings.experimental-features = "nix-command flakes";
  services = {
    qemuGuest.enable = true;
    openssh = {
      enable = true;
      ports = [ 22 ];
    };
  };
  # boot.initrd.availableKernelModules = [
  #   "uhci_hcd"
  #   "ehci_pci"
  #   "ahci"
  #   "virtio_pci"
  #   "virtio_scsi"
  #   "sd_mod"
  #   "sr_mod"
  # ];
  # boot.initrd.kernelModules = [ ];
  # boot.kernelModules = [ ];
  # boot.extraModulePackages = [ ];

  # fileSystems."/" =
  #   { device = "/dev/disk/by-uuid/301d5990-7186-4a90-94aa-997044007358";
  #     fsType = "ext4";
  #   };

  # swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it&#39;s
  # still possible to use this option, but it&#39;s recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.&lt;interface&gt;.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  networking.hostName = lib.mkDefault "nixos";

  # networking.interfaces.ens18.useDHCP = lib.mkDefault true;

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
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
