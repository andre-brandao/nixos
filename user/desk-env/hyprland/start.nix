{
  pkgs,
  inputs,
  lib,
  ...
}:{
  wayland.windowManager.hyprland.settings = {

    exec-once = [
      # "dunst"
      # "hyprpaper"
      # "hypridle"
      # "waybar"
      # "nwg-dock-hyprland -d"
      "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP QT_QPA_PLATFORMTHEME"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "dbus-update-activation-environment --systemd --all"
      # "systemctl --user import-environment PATH"
      # "xwaylandvideobridge"

      # "systemctl --user restart xdg-desktop-portal.service"
      "pypr"

      # "nm-applet --indicator"
      "swww-daemon"
      "protonmail-bridge --noninteractive"
      "uwsm app -- marble"
      "uwsm app -- marble-launcher"
      "uwsm finalize"
    ];

    exec = [

    ];
    exec-shutdown = [

    ];

  };
}
