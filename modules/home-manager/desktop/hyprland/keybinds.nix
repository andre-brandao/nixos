{
  inputs,
  settings,

  pkgs,
  lib,
  ...
}:
let
  scripts = import ./scripts.nix {
    inherit
      pkgs

      lib
      settings
      ;
  };
  inherit (scripts) launcher screenshot monitor-toggle;
in
{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    bindr = [ "SUPER, SUPER_L, exec, pkill ${launcher} || ${launcher}" ];
    bind = [
      # HYPR CONTROLS
      # "$mainMod,         RETURN,    exec,    ${launcher}"
      # "$mainMod,         R,         exec,    walker --width 700 --height 600"
      # "$mainMod,         J,         exec,    rofi -show window -show-icons"

      "SUPER,            P,         exec,    ${monitor-toggle}"
      # "$mainMod,         RETURN,    exec,    marble-launcher --open"
      # "$CTRL     SHIFT,  R,         exec,    astal -i marble -q; marble"
      # "SUPER,            Tab,       exec,    marble-launcher ':h'"

      "$mainMod,         T,                  togglefloating"
      "$mainMod,         G,                  togglegroup"
      "$mainMod  SHIFT,  F,                  fullscreen"
      "$mainMod,         W,                  killactive"
      "$mainMod,         N,                  changegroupactive, n"
      "$mainMod,         B,                  changegroupactive, b"
      "$mainMod,         D,         exec,    hyprctl keyword general:layout dwindle"
      "$mainMod,         M,         exec,    hyprctl keyword general:layout master"
      "$mainMod,         S,         exec,    hyprctl keyword general:layout scrolling"

      "$mainMod, period, layoutmsg, move +col"
      "$mainMod, comma, layoutmsg, move -col"
      "$mainMod SHIFT, period, layoutmsg, movewindowto r"
      "$mainMod SHIFT, comma, layoutmsg, movewindowto l"
      # "$mainMod SHIFT, up, layoutmsg, movewindowto u"
      # "$mainMod SHIFT, down, layoutmsg, movewindowto d"
      # LAUNCHERS
      # ZOOM
      "$mainMod,         Z,         exec,    pypr zoom ++0.5"
      "$mainMod  SHIFT,  Z,         exec,    pypr zoom"
      # OTHER
      "$mainMod  SHIFT,  Q,                  exit"
      "CTRL      ALT,    Delete,             exit"
      "ALT,              Tab,                cyclenext,"
      "ALT,              Tab,                bringactivetotop,"
      # "ALT SHIFT, Tab,                     cycleprev,"
      # "ALT SHIFT, Tab,                     bringactivetotop,"
      ",                Print,     exec,    ${screenshot}" # print screen
      "$mainMod,         Print,     exec,    hyprpicker -a -f hex" # color picker

      "SUPERALT,         G,                  togglespecialworkspace, gromit"
      ",                 F8,        exec,    gromit-mpx --undo"
      "SHIFT ,           F8,        exec,    gromit-mpx --redo"
    ];
  };
}
