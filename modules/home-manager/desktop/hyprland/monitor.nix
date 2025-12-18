{
  pkgs,
  config,
  inputs,
  ...
}:
{
  ## See https://wiki.hyprland.org/Configuring/Monitors/

  wayland.windowManager.hyprland.settings.monitor = [
    "eDP-1,highres,0x0,1" # laptop monitor
    "DP-3,highres,auto,1"
    " , preferred, auto, 1"
  ];
}
