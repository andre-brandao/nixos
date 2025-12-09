{
  pkgs,
  pkgs-unstable,
  config,
  inputs,
  ...
}:
{
  wayland.windowManager.hyprland = {
    plugins = with pkgs; [
      # hyprlandPlugins.hyprbars
      # hyprlandPlugins.hyprspace
    ];
    settings.bind = [
      # "$mainMod, O, overview:toggle"
      # "ALT,tab,hycov:toggleoverview"
      # "ALT,left,hycov:movefocus,l"
      # "ALT,right,hycov:movefocus,r"
      # "ALT,up,hycov:movefocus,u"
      # "ALT,down,hycov:movefocus,d"
    ];
    settings.plugin = {
      # hyprbars = {
      #   # example config
      #   bar_height = 20;
      #   bar_color =  "0xff${config.lib.stylix.colors.base03}";
      #   # example buttons (R -> L)
      #   # hyprbars-button = color, size, on-click
      #   # hyprbars-button = [
      #   #   "rgb(ff4040), 10, 󰖭, hyprctl dispatch killactive"
      #   #   "rgb(eeee11), 10, , hyprctl dispatch fullscreen 1"
      #   # ];
      # };

      # hycov = {
      #   overview_gappo = 60; # gaps width from screen
      #   overview_gappi = 24; # gaps width from clients
      #   hotarea_size = 10; # hotarea size in bottom left,10x10
      #   enable_hotarea = 1; # enable mouse cursor hotarea
      # };
      # touch_gestures = {
      #   long_press_delay = 400;

      #   workspace_swipe_fingers = 3;
      #   workspace_swipe_edge = "d";

      #   hyprgrass-bind = [
      #     " , swipe:4:d, killactive"
      #   ];
      #   hyprgrass-bindm = [
      #     " , longpress:2, movewindow"
      #     " , longpress:3, resizewindow"
      #   ];
      #   # hyprgrass-bind = "";

      # };
      #     hyprexpo = {
      #       columns = 3;
      #       gap_size = 5;
      #       bg_col = "0x33 ${config.lib.stylix.colors.base00}";
      #       workspace_method = "first 1"; # [center/first] [workspace] e.g. first 1 or center m+1

      #       enable_gesture = true; # laptop touchpad, 4 fingers
      #       gesture_fingers = 3; # 3 or 4

      #       gesture_distance = 300; # how far is the "max"
      #       gesture_positive = false; # positive = swipe down. Negative = swipe up.
      #     };
      #     # overview = {

      #     # };

    };
  };
}
