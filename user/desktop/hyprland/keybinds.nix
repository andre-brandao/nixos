{
  inputs,
  userSettings,
  pkgs-unstable,
  pkgs,
  lib,
  ...
}:
let
  scripts = import ./scripts.nix { inherit pkgs pkgs-unstable lib; };
  inherit (scripts) launcher screenshot;
in
{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    bind = [
      # HYPR CONTROLS
      "$mainMod,         RETURN,    exec,    ${launcher}"
      # "$mainMod,         RETURN,    exec,    marble-launcher --open"
      # "$CTRL     SHIFT,  R,         exec,    astal -i marble -q; marble"
      # "SUPER,            Tab,       exec,    marble-launcher ':h'"

      "$mainMod,         T,                  togglefloating"
      "$mainMod,         G,                  togglegroup"
      "$mainMod  SHIFT,  F,                  fullscreen"
      "$mainMod,         C,                  killactive"
      "$mainMod,         N,                  changegroupactive, n"
      "$mainMod,         B,                  changegroupactive, b"
      "$mainMod,         D,         exec,    hyprctl keyword general:layout dwindle"
      "$mainMod,         M,         exec,    hyprctl keyword general:layout master"
      # LAUNCHERS
      "$mainMod,         R,         exec,    rofi -show drun -show-icons"
      "$mainMod,         J,         exec,    rofi -show window -show-icons"
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
      '',                Print,     exec,    ${screenshot}'' # print screen
      "$mainMod,         Print,     exec,    hyprpicker -a -f hex" # color picker

      "SUPERALT,         G,                  togglespecialworkspace, gromit"
      ",                 F8,        exec,    gromit-mpx --undo"
      "SHIFT ,           F8,        exec,    gromit-mpx --redo"
    ];
  };
}
