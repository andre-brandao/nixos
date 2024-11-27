{
  pkgs,
  inputs,
  lib,
  ...
}:

let

  hyprshell = "${inputs.hyprshell.packages.${pkgs.system}.default}/bin/hyprshell";

in
{
  wayland.windowManager.hyprland.settings = {

    exec-once = [
      # "dunst"
      # "xwaylandvideobridge"
      "hyprpaper"
      "hypridle"
      # "waybar"
      # "nwg-dock-hyprland -d"
      "nm-applet --indicator"
      "systemctl --user import-environment PATH"
      "protonmail-bridge --noninteractive"
      # "systemctl --user restart xdg-desktop-portal.service"
      "pypr"
      # "ags run"
      hyprshell
    ];

    exec = [

    ];
    exec-shutdown = [

    ];

  };
}
