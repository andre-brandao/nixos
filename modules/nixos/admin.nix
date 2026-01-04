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
