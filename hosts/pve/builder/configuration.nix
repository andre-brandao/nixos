{
  pkgs,
  lib,
  settings,
  ...
}:
{
  imports =
    map lib.custom.relativeToNixOSModules [
      "pve-vm.nix"
      "nix.nix"
    ]
    ++ lib.custom.scanPaths ./modules;

  networking.hostName = "builder";

  environment.systemPackages = with pkgs; [
    git
    vim
    htop
    gh
    tmux
  ];

  services.tailscale.enable = true;

  # ARM64 emulation for building Raspberry Pi NixOS images
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  users.users.breno = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.bash;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILA+W8phzDb52WGDE02Y42PAd/NG7WHmyPfmzOlEqpms brenoca35@gmail.com"
    ];
  };

  nix.settings.trusted-users = [ "breno" ];

  security.sudo.extraRules = [
    {
      users = [ "breno" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  system.stateVersion = "24.11";
}
