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
      # "xwaylandvideobridge"
      # "hyprpaper"
      # "hypridle"
      # "swww-daemon"
      # "waybar"
      # "nwg-dock-hyprland -d"
      "systemctl --user import-environment PATH"
      "protonmail-bridge --noninteractive"
      # "systemctl --user restart xdg-desktop-portal.service"
      "pypr"
      "marble"
      "nm-applet --indicator"
    ];

    exec = [

    ];
    exec-shutdown = [

    ];

  };
}
