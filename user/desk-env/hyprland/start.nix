{
  pkgs,
  inputs,
  lib,
  ...
}:

let

  hyprshell = "${inputs.hyprshell.packages.${pkgs.system}.default}/bin/hyprshell";
  # marble = "${pkgs.gjs}/bin/gjs  -m ${inputs.hyprshell.packages.${pkgs.system}.default}/bin/marble";
  marble = "${inputs.marble-shell.packages.${pkgs.system}.default}/bin/marble";

in
{
  wayland.windowManager.hyprland.settings = {

    exec-once = [
      # "dunst"
      # "hyprpaper"
      # "hypridle"
      "swww-daemon"
      # "waybar"
      # "nwg-dock-hyprland -d"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "dbus-update-activation-environment --systemd --all"
      "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP QT_QPA_PLATFORMTHEME"
      # "systemctl --user import-environment PATH"
      "xwaylandvideobridge"

      "protonmail-bridge --noninteractive"
      # "systemctl --user restart xdg-desktop-portal.service"
      "pypr"
      "marble"
      "marble-launcher"
      # "nm-applet --indicator"
    ];

    exec = [

    ];
    exec-shutdown = [

    ];

  };
}
