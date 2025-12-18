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
    openssh.authorizedKeys.keys = settings.sshPublicKeys;
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
