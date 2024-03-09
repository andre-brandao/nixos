{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome3.gnome-tweaks
    gnomeExtensions.blur-my-shell
    gnomeExtensions.gnome-40-ui-improvements
    gnomeExtensions.vitals
    gnomeExtensions.caffeine
    gnomeExtensions.dash-to-dock
    gnomeExtensions.gsconnect
  ];
}
