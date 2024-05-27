# home.nix

{
  inputs,
  pkgs,
  config,
  lib,
  userSettings,
  ...
}:
let

  mainMod = "SUPER";
  keybindings = [
    "$mainMod, A, exec, ${userSettings.term}"

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
  ];
  workspaceSettings = [
    #these apps will open on the specified workspace when you firt open them
    "8, on-created-empty:vesktop"
    "9, on-created-empty:thunderbird"
    # "special:exposed,gapsout:60,gapsin:30,bordersize:5,border:true,shadow:false"
  ];
  # https://github.com/hyprland-community/pyprland
  scratchpads = [
    {
      bind = "ALT,Z,exec,pypr toggle term && hyprctl dispatch bringactivetotop";
      scratchpad = ''
        [scratchpads.term]
        animation = "fromBottom"
        command = "${userSettings.term} --class dropterm"
        class = "dropterm"
        size = "85% 85%"
      '';
    }
    {
      bind = "$mainMod, F,exec,pypr toggle filemanager && hyprctl dispatch bringactivetotop";
      scratchpad = ''
        [scratchpads.filemanager]
        animation = "fromRight"
        command = "nautilus"
        class = "nautilus"
        size = "85% 85%"
      '';
    }
    {
      bind = "$mainMod,V,exec,pypr toggle volume && hyprctl dispatch bringactivetotop";
      scratchpad = ''
        [scratchpads.volume]
        animation = "fromRight"
        command = "pavucontrol"
        class = "pavucontrol"
        lazy = true
        size = "25% 60%"
        position = "70% 5%"
        unfocus = "hide"
        hysteresis=2
      '';
    }
    {
      bind = "$mainMod, P,exec,pypr toggle network && hyprctl dispatch bringactivetotop";
      scratchpad = ''
        [scratchpads.network]
        animation = "fromRight"
        command = "nm-connection-editor"
        class = "nm-connection-editor"
        lazy = true
        size = "25% 60%"
        position = "70% 5%"
      '';
    }
    {
      # bluetooth
      bind = "$mainMod, B,exec,pypr toggle bluetooth && hyprctl dispatch bringactivetotop";
      scratchpad = ''
        [scratchpads.bluetooth]
        animation = "fromRight"
        command = "blueman-manager"
        class = "blueman-manager"
        lazy = true
        size = "25% 60%"
        position = "70% 5%"
        unfocus = "hide"
        hysteresis=2

      '';
    }
    {
      bind = "$mainMod,S,exec,pypr toggle music && hyprctl dispatch bringactivetotop";
      scratchpad = ''
        [scratchpads.music]
        animation = "fromRight"
        command = "spotify"
        class = "spotify"
        size = "45% 85%"
        unfocus = "hide"
        hysteresis=2
      '';
    }
    {
      bind = "$mainMod,B,exec,pypr toggle bitwarden && hyprctl dispatch bringactivetotop";
      scratchpad = ''
        [scratchpads.bitwarden]
        animation = "fromTop"
        command = "bitwarden"
        class = "bitwarden"
        size = "45% 70%"
        unfocus = "hide"
        hysteresis=2
      '';
    }
    # -----------------------------
    # *Tip use SUPER + J to get the name of the class
    # -----------------------------
    {
      bind = "$mainMod, W,exec,pypr toggle whatsapp && hyprctl dispatch bringactivetotop";
      scratchpad = ''
        [scratchpads.whatsapp]
        animation = "fromLeft"
        command = "brave --profile-directory=Default --app=https://web.whatsapp.com/"
        class = "brave-web.whatsapp.com__-Default"
        size = "75% 60%"
        process_tracking = false 
      '';
    }
    {
      bind = "$mainMod,G,exec,pypr toggle openai && hyprctl dispatch bringactivetotop";
      scratchpad = ''
        [scratchpads.openai]
        animation = "fromRight"
        command = "brave --profile-directory=Default --app=https://chat.openai.com"
        class = "brave-chat.openai.com__-Default"
        size = "45% 85%"
        process_tracking = false 
      '';
    }
    {
      bind = "$mainMod,N,exec,pypr toggle notion && hyprctl dispatch bringactivetotop";
      scratchpad = ''
        [scratchpads.notion]
        animation = "fromLeft"
        command = "brave --profile-directory=Default --app=https://notion.so"
        class = "brave-notion.so__-Default"
        size = "95% 85%"
        process_tracking = false 
      '';
    }
    {
      bind = "$mainMod,P,exec,pypr toggle proton && hyprctl dispatch bringactivetotop";
      scratchpad = ''
        [scratchpads.proton]
        animation = "fromLeft"
        command = "brave --profile-directory=Default --app=https://mail.proton.me/u/2/inbox"
        class = "brave-mail.prton.me__u_2_inbox-Default"
        size = "95% 85%"
        process_tracking = false 
      '';
    }
  ];
in
{
  imports = [
    ../extras/bar/waybar.nix
    ../extras/bar/nwg-dock.nix
    ../extras/notification/dunst.nix
    # ./ags.nix
    ./lockscreen.nix
    ./xremap.nix
  ];

  home.packages = with pkgs; [
    # hyprland packages
    hyprland-protocols
    hypridle
    hyprlock
    hyprpicker
    hyprpaper

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
    vesktop # discord client

    waybar
    dunst
    nwg-dock-hyprland
    nwg-drawer
    nwg-launchers
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;

    systemd.enable = true;
    xwayland.enable = true;

    plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
      # inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
      # inputs.hycov.packages.${pkgs.system}.hycov
    ];
    settings.plugin = {
      # hyprexpo = {
      #   columns = 3;
      #   gap_size = 5;
      #   bg_col = "0x33 ${config.lib.stylix.colors.base00}";

      #   workspace_method = "first 1"; # [center/first] [workspace] e.g. first 1 or center m+1
      #   enable_gesture = true; # laptop touchpad, 4 fingers
      #   gesture_distance = 300; # how far is the "max"
      #   gesture_positive = true; # positive = swipe down. Negative = swipe up.
      # };
      # hycov = {
      #   overview_gappo = 60; # gaps width from screen
      #   overview_gappi = 24; # gaps width from clients
      #   hotarea_size = 10; # hotarea size in bottom left,10x10
      #   enable_hotarea = 1; # enable mouse cursor hotarea
      # };
    };

    settings = {

      #  lib.filter is a helper function that filters out null values
      exec-once = [
        "dbus-update-activation-environment DISPLAY XAUTHORITY WAYLAND_DISPLAY"
        "dunst"
        #  "ags"
        # "xwaylandvideobridge"
        "hyprpaper"
        "hypridle"
        "waybar"
        "pypr"
        "protonmail-bridge --noninteractive"
        ""
      ];
      ## See https://wiki.hyprland.org/Configuring/Monitors/
      # monitor = "DP-1, 1920x1200, auto, 1";
      monitor = [
        "eDP-1,highres,0x0,1"
        "DP-1,2560x1440,auto,1" # 2560x1440
        # "DP-1,highres,auto,1" # 2560x1440

        # DP-3,1920x1080@60,0x0,1,mirror,DP-2 #exemple of mirror
      ];

      xwayland = {
        force_zero_scaling = true;
      };
      env = "GDK_SCALE,2";

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input = {
        kb_layout = "us,br";
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:win_space_toggle";
        kb_rules = "";

        follow_mouse = 1;

        touchpad = {
          natural_scroll = "yes";
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

        # "col.inactive_border" = "rgba(595959aa)";
        # "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "0x33 ${config.lib.stylix.colors.base00}";
        "col.active_border" = ''0xff${config.lib.stylix.colors.base08} 0xff${config.lib.stylix.colors.base0A} 45deg'';

        # layout = "dwindle";
        layout = "master";

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 6;

        # blur = {
        #   enabled = true;
        #   size = 3;
        #   passes = 1;
        # };
        blur.enabled = false; # disabled for battery life

        # drop_shadow = "yes";
        drop_shadow = false;
        shadow_range = 4;
        shadow_render_power = 3;
        # "col.shadow" = "rgba(1a1a1aee)";

        inactive_opacity = 0.9;
      };

      animations = {
        enabled = "yes";

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"

          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      master = {
        #  # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true;
      };
      dwindle = {
        #   # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = "yes";
        preserve_split = "yes";
        no_gaps_when_only = 2;
      };
      gestures = {
        # # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = true;
        workspace_swipe_forever = true;
        # workspace_swipe_numbered = true;
      };

      misc = {
        #  # See https://wiki.hyprland.org/Configuring/Variables/ for more
        force_default_wallpaper = 0;
        focus_on_activate = true;
      };

      workspace = workspaceSettings;

      "$mainMod" = mainMod;
      bind = [
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
      ] ++ keybindings ++ map (s: s.bind) scratchpads;

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

      windowrule =
        let
          f = regex: "float, ^(${regex})$";
        in
        [
          (f "org.gnome.Calculator")
          (f "org.gnome.Nautilus")
          (f "pavucontrol")
          (f "nm-connection-editor")
          (f "blueberry.py")
          (f "org.gnome.Settings")
          (f "org.gnome.design.Palette")
          (f "xdg-desktop-portal")
          (f "xdg-desktop-portal-gnome")
          (f "transmission-gtk")
          (f "Bitwarden")
          (f "Spotify")
          (f ".blueman-manager-wrapped")
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

  # SCRATCHPADS
  # https://github.com/hyprland-community/pyprland
  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = ["scratchpads", "magnify"]

    ${builtins.concatStringsSep "\n" (map (s: s.scratchpad) scratchpads)}
  '';

  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ${config.stylix.image}

    wallpaper = eDP-1,${config.stylix.image}

    wallpaper = HDMI-A-1,${config.stylix.image}

    wallpaper = DP-1,${config.stylix.image}
  '';


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
