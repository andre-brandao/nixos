{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    workspace = [
      "1, monitor:eDP-1"
      "2, monitor:eDP-1"
      "3, monitor:DP-3"
      "4, monitor:DP-3"
      "5, monitor:DP-3"
      "6, monitor:DP-3"
      "7, monitor:DP-3"
      "8, monitor:DP-3"
      "9, monitor:DP-3"

      #these apps will open on the specified workspace when you firt open them
      "8, on-created-empty:discord"
      "9, on-created-empty:thunderbird"
      # "special:exposed,gapsout:60,gapsin:30,bordersize:5,border:true,shadow:false"

      # # Smart gaps
      "w[tv1]s[false], gapsout:0, gapsin:0"
      "f[1]s[false], gapsout:0, gapsin:0"
      # drawing
      "special:gromit, gapsin:0, gapsout:0, on-created-empty: gromit-mpx -a"
    ];
    windowrule = [
      # # Smart Gaps
      "bordersize 0, floating:0, onworkspace:w[tv1]s[false]"
      "rounding 0, floating:0, onworkspace:w[tv1]s[false]"
      "bordersize 0, floating:0, onworkspace:f[1]s[false]"
      "rounding 0, floating:0, onworkspace:f[1]s[false]"

      # Deds Launcher
      "float, title:^DedsLauncher$"
      "pin, title:^DedsLauncher$"
      # PIP
      "float, title:^Picture-in-Picture$"
      "pin, title:^Picture-in-Picture$"
      "noinitialfocus, title:^Picture-in-Picture$"
      "move 69% 69%, title:^Picture-in-Picture$"
      "opacity 1.0 1.0, title:^Picture-in-Picture$"

      # Proton vpn ## title = Proton VPN initialClass = .protonvpn-app-wrapped
      "float, title:^Proton VPN$"
      "pin, title:^Proton VPN$"
      "noinitialfocus, title:^Proton VPN$"
      "move 10% 10%, title:^Proton VPN$"
      "opacity 1.0 1.0, title:^Proton VPN$"
      "size 20% 50%, title:^Proton VPN$"

      # other
      "group set, initialClass:zen-twilight"
      # drawing
      #
      "noblur, class:^Gromit-mpx$"
      "noshadow, class:^Gromit-mpx$"
      "opacity 1 override 1 override, class:^Gromit-mpx$"
      "size 100% 100%, class:^Gromit-mpx$"

    ];

  };
}
