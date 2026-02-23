{ pkgs, ... }:
{
  # imports = [
  #   ../swaync
  # ];
  programs.swaylock.enable = true; # Super+Alt+L in the default setting (screen
  services.swayidle.enable = true; # idle management daemon
  services.polkit-gnome.enable = true; # polkit

  home.packages = with pkgs; [
    niri-scratchpad
    # networkmanagerapplet
    gpuishell
    unstable.wayscriber
  ];
}
