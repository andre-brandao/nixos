# home.nix

{
  inputs,
  pkgs,
  config,
  lib,
  userSettings,
  ...
}:
{
  imports = [
    ./start.nix
    ./keybinds.nix
    ./scratchpads.nix
    ./rules.nix

    # ../extras/bar/waybar.nix
    # ../extras/bar/ags
    # ../extras/bar/nwg-dock.nix
    # ../extras/notification/dunst.nix
    ./monitor.nix
    ./plugins.nix
    ./lockscreen.nix
    # ./xremap.nix
  ];

  home.packages = with pkgs; [
    # hyprland packages
    hyprland-protocols
    hypridle
    hyprlock
    hyprpicker
    hyprpaper
    swww

    inputs.hyprsysteminfo.packages.${pkgs.system}.default

    pyprland

    networkmanagerapplet # network manager
    pavucontrol # volume control
    pamixer # volume control

    wl-clipboard # clipboard manager

    grim # screenshot
    swappy
    slurp

    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    xdg-utils # for opening files with default applications

    # xwaylandvideobridge # screen sharing
    # vesktop # discord client

    # waybar
    # dunst
    # nwg-dock-hyprland
    # nwg-drawer
    # nwg-launchers
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;

    systemd.enable = true;
    xwayland.enable = true;

    settings = {

      xwayland = {
        force_zero_scaling = true;
      };
      env = "GDK_SCALE,2";

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input = {
        kb_layout = "us,br";
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:win_space_toggle,caps:escape";
        kb_rules = "";

        follow_mouse = 1; # Cursor movement will always change focus to the window under the cursor.

        focus_on_close = 1;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          # clickfinger_behavior = true;
        };

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      general = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        resize_on_border = true;

        gaps_in = 5;
        gaps_out = 15;
        border_size = 2;

        "col.inactive_border" = "0x33${config.lib.stylix.colors.base03}";
        "col.active_border" =
          ''0xff${config.lib.stylix.colors.base0D} 0xff${config.lib.stylix.colors.base0C} 45deg'';

        # layout = "dwindle";
        layout = "master";

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;
        snap = {
          enabled = true;
        };
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 6;
        blur.enabled = false; # disabled for battery life
        shadow.enabled = false;

        # "col.shadow" = "rgba(1a1a1aee)";

        inactive_opacity = 0.9;
      };

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
          "border, 1, 10, default"

          # "borderangle, 1, 8, default"
          # "fade, 1, 7, default"
          # "workspaces, 1, 6, default"
          "windowsIn, 1, 6, winIn, popin"
          "windowsOut, 1, 5, winOut, popin"
          "windowsMove, 1, 5, wind, slide"
          "borderangle, 1, 100, linear, loop"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
          "windows, 1, 6, wind, slide"
          "specialWorkspace, 1, 6, default, slidefadevert -50%"
        ];
      };

      master = {
        #  # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        # new_is_master = true;
        # no_gaps_when_only = 1;
      };
      dwindle = {
        #   # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = "yes";
        preserve_split = "yes";
        # no_gaps_when_only = 2;
      };
      gestures = {
        # # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = true;
        workspace_swipe_forever = true;
        workspace_swipe_cancel_ratio = 0.15;
        # workspace_swipe_numbered = true;
        workspace_swipe_direction_lock = false;
      };

      misc = {
        #  # See https://wiki.hyprland.org/Configuring/Variables/ for more
        force_default_wallpaper = 0;
        focus_on_activate = true;
      };
      # debug = {
      #   disable_logs = false;

      # };

      # "$mainMod" = mainMod;
      bind = [
        "$mainMod, A, exec, ${userSettings.term}"
        #WORKSPACE SWITCH
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        #MOVE CURRENT WINDOW TO WORKSPACE
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        # map scratchpad bindings as an array
      ];

      "$scratchpadsize" = "size 80% 85%";
      "$scratchpad" = "class:^(scratchpad)$";
      windowrulev2 = [
        "float,$scratchpad"
        "$scratchpadsize,$scratchpad"
        "workspace special silent,$scratchpad"
        "center,$scratchpad"

        # # SCREEN SHARING
        "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
        "maxsize 1 1,class:^(xwaylandvideobridge)$"
        "noblur,class:^(xwaylandvideobridge)$"

        # FLOATING WINDOWS
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      binds = {
        allow_workspace_cycles = true;
      };

      bindle =
        let
          brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
          pactl = "${pkgs.pulseaudio}/bin/pactl";
        in
        [

          ",XF86MonBrightnessUp,   exec, ${brightnessctl} set +5%"
          ",XF86MonBrightnessDown, exec, ${brightnessctl} set  5%-"
          ",XF86KbdBrightnessUp,   exec, ${brightnessctl} -d asus::kbd_backlight set +1"
          ",XF86KbdBrightnessDown, exec, ${brightnessctl} -d asus::kbd_backlight set  1-"
          ",XF86AudioRaiseVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ +5%"
          ",XF86AudioLowerVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ -5%"
        ];

      bindl =
        let
          playerctl = "${pkgs.playerctl}/bin/playerctl";
          pactl = "${pkgs.pulseaudio}/bin/pactl";
        in
        [
          ",XF86AudioPlay,    exec, ${playerctl} play-pause"
          ",XF86AudioStop,    exec, ${playerctl} pause"
          ",XF86AudioPause,   exec, ${playerctl} pause"
          ",XF86AudioPrev,    exec, ${playerctl} previous"
          ",XF86AudioNext,    exec, ${playerctl} next"
          ",XF86AudioMicMute, exec, ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
          ",XF86AudioMute,    exec, ${pactl} set-sink-mute @DEFAULT_SINK@ toggle"
        ];
    };
  };

  # home.file.".config/hypr/hyprpaper.conf".text = ''
  #   preload = ${config.stylix.image}

  #   wallpaper = eDP-1,${config.stylix.image}

  #   wallpaper = HDMI-A-1,${config.stylix.image}

  #   wallpaper = DP-1,${config.stylix.image}
  #   wallpaper = DP-2,${config.stylix.image}
  #   wallpaper = DP-3,${config.stylix.image}

  # '';

  home.file.".config/swappy/config".text = ''
    [Default]
    save_dir=$HOME/Pictures/Screenshots
    save_filename_format=swappy-%Y%m%d-%H%M%S.png
    show_panel=false
    line_size=5
    text_size=20
    text_font=sans-serif
    paint_mode=brush
    early_exit=false
    fill_shape=false
  '';
}
