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
      # Smart Gaps
      "border_size 0, rounding 0, match:float 0, match:workspace w[tv1]s[false]"
      "border_size 0, match:float 0, match:workspace f[1]zs[false]"
      "rounding 0, match:float 0, match:workspace f[1]s[false]"
      # Deds Launcher
      "float on, pin on, match:title ^DedsLauncher$"
      # PIP
      "float on, pin on, no_initial_focus on, move ((monitor_w*0.69)) ((monitor_h*0.69)), opacity 1.0 1.0, match:title ^Picture-in-Picture$"
      "float on, pin on, no_initial_focus on, move ((monitor_w*0.69)) ((monitor_h*0.69)), opacity 1.0 1.0, match:title ^Picture in picture$"
      # proton vpn
      "float on, pin on, no_initial_focus on, move ((monitor_w*0.1)) ((monitor_h*0.1)), opacity 1.0 1.0, size (monitor_w*0.2) (monitor_h*0.5), match:title ^Proton VPN$"
      # other
      "group set, match:initial_class zen-twilight"
      "float on, match:title ^Bitwarden$"

      # drawing
      "no_blur on, no_shadow on, opacity 1 override 1 override, size (monitor_w*1) (monitor_h*1), match:class ^Gromit-mpx$"

      # "float on, workspace special silent, center on, $scratchpad"
      # "$scratchpadsize, $scratchpad"
    ];

  };
}
