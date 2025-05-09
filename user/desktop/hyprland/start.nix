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

      # "nm-applet --indicator"
      "uwsm app -- protonmail-bridge --noninteractive"
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
