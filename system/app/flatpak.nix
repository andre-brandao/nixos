{pkgs, userSettings, ... }:

{
  # Need some flatpaks
  services.flatpak.enable = true;
    users.users.${userSettings.username} = {
    packages = with pkgs; [
      flatpak
      gnome.gnome-software
    ];
  };

}
