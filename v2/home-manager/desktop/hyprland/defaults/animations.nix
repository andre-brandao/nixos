{ pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    animations = {
      enabled = "yes";

      # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

      bezier = [
        "myBezier, 0.05, 0.9, 0.1, 1.05"
        "wind, 0.05, 0.9, 0.1, 1.05"
        "winIn, 0.1, 1.1, 0.1, 1.0"
        "winOut, 0.3, -0.3, 0, 1"
        "liner, 1, 1, 1, 1"
        "linear, 0.0, 0.0, 1.0, 1.0"

      ];

      animation = [
        # "windows, 1, 7, myBezier"
        # "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 2, default"

        # "borderangle, 1, 8, default"
        # "fade, 1, 7, default"
        "windowsIn, 1, 6, winIn, popin"
        "windowsOut, 1, 5, winOut, popin"
        "windowsMove, 1, 5, wind, slide"
        "borderangle, 1, 100, linear, loop"
        "fade, 1, 4, default"
        # "workspaces, 1, 6, default"
        # "workspaces, 1, 5, wind"
        "workspaces, 1, 2, default, slide"
        # "windows, 1, 6, wind, slide"
        "windows, 1, 3, default, popin 80%"
        "specialWorkspace, 1, 6, default, slidefadevert -50%"
      ];
    };
  };
}
