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
    "DP-3,2560x1440,auto,1" # 2560x1440
    "DP-2,2560x1440,auto,1" # 2560x1440
    "DP-1,2560x1440,auto,1" # 2560x1440

    # DP-3,1920x1080@60,0x0,1,mirror,DP-2 #exemple of mirror
  ];
}
