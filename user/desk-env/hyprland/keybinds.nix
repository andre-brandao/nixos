{ userSettings, ... }:
{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    bind = [
      # "$mainMod, A, exec,            ${userSettings.term}"

      "$mainMod, T,                  togglefloating"

      # "$mainMod, W, exec,            ${userSettings.browser}"
      "$mainMod, RETURN, exec,       marble-launcher --open"
      "$CTRL SHIFT, R, exec,         astal -i marble -q; marble"

      "SUPER, Tab, exec,             marble-launcher ':h'"

      # ROFI
      "$mainMod, J, exec,            rofi -show window -show-icons"
      "$mainMod, R, exec,            rofi -show drun -show-icons"

      '',Print,exec,                 grim -g "$(slurp)" - | swappy -f -'' # print screen
      "$mainMod, Print, exec,        hyprpicker -a -f hex" # color picker

      "$mainMod SHIFT, F,            fullscreen"
      "$mainMod, C,                  killactive"
      "$mainMod SHIFT, Q,            exit"
      "CTRL ALT, Delete,             exit"

      # layout
      "$mainMod, D, exec,            hyprctl keyword general:layout dwindle"
      "$mainMod, M, exec,            hyprctl keyword general:layout master"

      "ALT, Tab,                     cyclenext,"
      # "ALT SHIFT, Tab,               cycleprev,"
      "ALT, Tab,                     bringactivetotop,"
      # "ALT SHIFT, Tab,               bringactivetotop,"

      #  "mainMod, E,hycov:toggleoverview"

      # "$mainMod, E, hyprexpo:expo, toggle"
      # "$mainMod, E, overview:toggle"

      "$mainMod, Z, exec,            pypr zoom ++0.5"
      "$mainMod SHIFT,Z, exec,       pypr zoom"

    ];
  };
}
