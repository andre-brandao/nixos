{ userSettings, ... }:
{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    bind = [
      # "$mainMod, A, exec, ${userSettings.term}"

      "$mainMod, T, togglefloating"

      # "$mainMod, W, exec, ${userSettings.browser}"
      # ROFI
      "$mainMod, R, exec, rofi -show drun -show-icons"
      "$mainMod, RETURN, exec, rofi -show drun -show-icons"
      "$mainMod, J, exec, rofi -show window -show-icons"

      "$mainMod, C, killactive"
      "$mainMod SHIFT, Q, exit"
      "CTRL ALT, Delete, exit"

      # layout
      "$mainMod, D, exec, hyprctl keyword general:layout dwindle"
      "$mainMod, M, exec, hyprctl keyword general:layout master"

      '',Print,exec,grim -g "$(slurp)" - | swappy -f -'' # print screen
      "$mainMod, Print, exec, hyprpicker -a -f hex" # color picker

      "ALT, Tab, cyclenext,"
      "ALT, Tab, bringactivetotop,"
      # "ALT SHIFT, Tab, cycleprev,"
      # "ALT SHIFT, Tab, bringactivetotop,"

      #  "mainMod, E,hycov:toggleoverview"

      # "$mainMod, E, hyprexpo:expo, toggle"
      # "$mainMod, E, overview:toggle"

    
    ];
  };
}
