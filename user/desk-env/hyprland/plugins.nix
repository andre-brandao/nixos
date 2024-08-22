{
  pkgs,
  config,
  inputs,
  ...
}:
{
  wayland.windowManager.hyprland = {
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
      # inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
      # inputs.hycov.packages.${pkgs.system}.hycov
    ];
    settings.plugin = {
      hyprexpo = {
        columns = 3;
        gap_size = 5;
        bg_col = "0x33 ${config.lib.stylix.colors.base00}";
        workspace_method = "first 1"; # [center/first] [workspace] e.g. first 1 or center m+1

        enable_gesture = true; # laptop touchpad, 4 fingers
        gesture_fingers = 3; # 3 or 4

        gesture_distance = 300; # how far is the "max"
        gesture_positive = false; # positive = swipe down. Negative = swipe up.
      };
      # hycov = {
      #   overview_gappo = 60; # gaps width from screen
      #   overview_gappi = 24; # gaps width from clients
      #   hotarea_size = 10; # hotarea size in bottom left,10x10
      #   enable_hotarea = 1; # enable mouse cursor hotarea
      # };
      # overview = {

      # };
    };
  };
}