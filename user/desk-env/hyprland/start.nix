{ ... }:
{
  wayland.windowManager.hyprland.settings.exec-once = [
    # "dunst"
    # "xwaylandvideobridge"
    "hyprpaper"
    "hypridle"
    "ags"
    # "waybar"
    # "nwg-dock-hyprland -d"
    "pypr"
    "nm-applet --indicator"
    "systemctl --user import-environment PATH"
    "protonmail-bridge --noninteractive"
    # "systemctl --user restart xdg-desktop-portal.service"
  ];
}
