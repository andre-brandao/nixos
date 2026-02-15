{
  inputs,
  settings,
  config,
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

  mkMenu =
    menu:
    let
      inherit (config.lib.stylix.colors.withHashtag) base00 base05 base0D;
      configFile = pkgs.writeText "config.yaml" (
        lib.generators.toYAML { } {
          anchor = "bottom-right";
          background = base00;
          color = base05;
          border = base0D;
          margin_right = 25;
          margin_bottom = 25;
          margin_left = 25;
          margin_top = 25;

          inherit menu;
        }
      );
    in
    pkgs.writeShellScriptBin "my-menu" "
    exec ${lib.getExe pkgs.wlr-which-key} ${configFile}
  ";
in
{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    bindr = [
      # "SUPER, SUPER_L, exec, pkill ${launcher} || ${launcher}"
      "SUPER, SUPER_L, exec, gpuishell"
    ];
    bind = [
      # HYPR CONTROLS
      "$mainMod,           R,         exec,    pkill ${launcher} || ${launcher}"
      (
        "$mainMod,         D,         exec, "
        + lib.getExe (mkMenu [
          {
            key = "f";
            desc = "Firefox";
            cmd = "firefox";
          }
          {
            key = "t";
            desc = "Terminal";
            cmd = "ghostty";
          }
          {
            key = "r";
            desc = "Remote Desktop";
            cmd = "remmina";
          }
          {
            key = "p";
            desc = "Power";
            submenu = [
              {
                key = "s";
                desc = "Sleep";
                cmd = "systemctl suspend";
              }
              {
                key = "r";
                desc = "Reboot";
                cmd = "reboot";
              }
              {
                key = "o";
                desc = "Off";
                cmd = "poweroff";
              }
            ];
          }
        ])
      )
      # "$mainMod,         R,         exec,    walker --width 700 --height 600"
      # "$mainMod,         J,         exec,    rofi -show window -show-icons"
      # VIM NAVIGATION
      "$mainMod,         H,         layoutmsg, focus left"
      "$mainMod,         J,         layoutmsg, focus down"
      "$mainMod,         K,         layoutmsg, focus up"
      "$mainMod,         L,         layoutmsg, focus right"
      "$mainMod SHIFT,   H,         layoutmsg, movewindowto l"
      "$mainMod SHIFT,   K,         layoutmsg, movewindowto u"
      "$mainMod SHIFT,   J,         layoutmsg, movewindowto d"
      "$mainMod SHIFT,   L,         layoutmsg, movewindowto r"

      "$mainMod,         period,    layoutmsg, move +col"
      "$mainMod,         comma,     layoutmsg, move -col"
      "$mainMod SHIFT,   period,    layoutmsg, movewindowto r"
      "$mainMod SHIFT,   comma,     layoutmsg, movewindowto l"
      # "$mainMod SHIFT, up, layoutmsg, movewindowto u"
      # "$mainMod SHIFT, down, layoutmsg, movewindowto d"

      "SUPER,            P,         exec,    ${monitor-toggle}"
      # "$mainMod,         RETURN,    exec,    marble-launcher --open"
      # "$CTRL     SHIFT,  R,         exec,    astal -i marble -q; marble"
      # "SUPER,            Tab,       exec,    marble-launcher ':h'"

      "$mainMod,         T,                  togglefloating"
      "$mainMod  SHIFT,  F,                  fullscreen"
      "$mainMod,         W,                  killactive"
      # "$mainMod,         G,                  togglegroup"
      # "$mainMod,         N,                  changegroupactive, n"
      # "$mainMod,         B,                  changegroupactive, b"
      # "$mainMod,         D,         exec,    hyprctl keyword general:layout dwindle"
      # "$mainMod,         M,         exec,    hyprctl keyword general:layout master"
      # "$mainMod,         S,         exec,    hyprctl keyword general:layout scrolling"

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
