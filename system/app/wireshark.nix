{ pkgs, userSettings, ... }:
{
  programs = {
    wireshark.enable = true;
  };

  environment.systemPackages = with pkgs; [ wireshark ];

  users.users.${userSettings.username}.extraGroups = [ "wireshark" ];
}
