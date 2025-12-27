{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  wayland.windowManager.hyprland.settings = {

    exec-once = [
      "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP QT_QPA_PLATFORMTHEME"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "dbus-update-activation-environment --systemd --all"
      # "systemctl --user import-environment PATH"
      "swww-daemon"
      "swaync -s"
      "syshud -p right -o v"
      "pypr"
      # "waybar"
      # "uwsm app -- caelestia-shell -d"
      "uwsm app -- ashell"

      # "nm-applet --indicator"
      "uwsm app -- protonmail-bridge --noninteractive"
      "systemctl --user start elephant.service"
      "tailscale systray"
      # "uwsm app -- marble"
      # "uwsm app -- marble-launcher"
      "uwsm finalize"
    ];

    exec = [

    ];
    exec-shutdown = [

    ];

  };
}
