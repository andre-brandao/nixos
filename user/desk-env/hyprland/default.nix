# home.nix

{ inputs, pkgs, config, userSettings, ... }:
let

  playerctl = "${pkgs.playerctl}/bin/playerctl";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
in
{
  imports = [
    ./waybar.nix
    ./dunst.nix
    # ./ags.nix
    ./lockscreen.nix
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

    xfce.thunar # file manager

    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    xdg-utils # for opening files with default applications

    # xwaylandvideobridge # screen sharing
    vesktop # discord client

    waybar
    dunst
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    systemd.enable = true;
    xwayland.enable = true;

    settings = {

      #  lib.filter is a helper function that filters out null values
      exec-once = [
        "dunst"
        #  "ags"

        "pypr"

        # "xwaylandvideobridge"

        "waybar"
        # tray icons
        "nm-applet --indicator"
        "blueman-applet"
        "${userSettings.browser}"
        "hyprpaper"
        "hypridle"
      ];
      ## See https://wiki.hyprland.org/Configuring/Monitors/
      # monitor = "DP-1, 1920x1200, auto, 1";
      monitor = "eDP-1,highres,0x0,1";

      xwayland = { force_zero_scaling = true; };
      env = "GDK_SCALE,2";

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input = {
        kb_layout = "us,br";
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:win_space_toggle";
        kb_rules = "";

        follow_mouse = 1;

        touchpad = { natural_scroll = "yes"; };

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      general = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        resize_on_border = true;

        gaps_in = 5;
        gaps_out = 5;
        border_size = 1;

        # "col.inactive_border" = "rgba(595959aa)";
        # "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "0x33" + config.lib.stylix.colors.base00;
        "col.active_border" = "0xff" + config.lib.stylix.colors.base08;

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
        blur.enabled = false;
        # drop_shadow = "yes";
        drop_shadow = false;
        shadow_range = 4;
        shadow_render_power = 3;
        # "col.shadow" = "rgba(1a1a1aee)";
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
      };
      gestures = {
        # # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = true;
      };

      misc = {
        #  # See https://wiki.hyprland.org/Configuring/Variables/ for more
        force_default_wallpaper = -1;
      };

      "$mainMod" = "SUPER";
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
        "$mainMod SHIFT, 0, movetoworkspace, 1"

        # Example special workspace (scratchpad)
        # "$mainMod, S, togglespecialworkspace, magic"
        # "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # ----- OTHER KEYBINDINGS --------

        # "$mainMod, Q, exec, ${userSettings.term}"
        "$mainMod, A, exec, ${userSettings.term}"

        "$mainMod, T, togglefloating"

        # "$mainMod, W, exec, ${userSettings.browser}"
        # ROFI
        "$mainMod, S, exec, rofi -show drun -show-icons"
        "$mainMod, RETURN, exec, rofi -show drun -show-icons"

        "$mainMod, J, exec, rofi -show window -show-icons"

        # kill window
        "$mainMod, C, killactive"

        # "$mainMod, E, exec, ${pkgs.xfce.thunar}/bin/thunar"
        "$mainMod, E, exec, pypr toggle filemanager && hyprctl dispatch bringactivetotop"

        "$mainMod SHIFT, Q, exit"
        "CTRL ALT, Delete, exit"

        # print screen
        '',Print,exec,grim -g "$(slurp)" - | swappy -f -''
        # color picker
        "$mainMod, Print, exec, hyprpicker -a -f hex"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        #  ---------- Scratchpad ---------
        "ALT,Z,exec,pypr toggle term && hyprctl dispatch bringactivetotop"
        "$mainMod,Z,exec,pypr toggle term && hyprctl dispatch bringactivetotop"

        "$mainMod,V,exec,pypr toggle volume && hyprctl dispatch bringactivetotop"
        "$mainMod,M,exec,pypr toggle music && hyprctl dispatch bringactivetotop"
        "$mainMod,B,exec,pypr toggle bitwarden && hyprctl dispatch bringactivetotop"

        # "$mainMod,T,exec,pypr toggle btm && hyprctl dispatch bringactivetotop"
        "$mainMod, W,exec,pypr toggle whatsapp && hyprctl dispatch bringactivetotop"
        "$mainMod,G,exec,pypr toggle openai && hyprctl dispatch bringactivetotop" # chat gpt
        "$mainMod,N,exec,pypr toggle notion && hyprctl dispatch bringactivetotop" # chat gpt

        # "$mainMod,G,exec,brave --profile-directory=Default --app=https://chat.openai.com" #chat gpt

      ];
      "$scratchpadsize" = "size 80% 85%";
      "$scratchpad" = "class:^(scratchpad)$";
      windowrulev2 = [
        "float,$scratchpad"
        "$scratchpadsize,$scratchpad"
        "workspace special silent,$scratchpad"
        "center,$scratchpad"

        # # SCREEN SHARING
        # "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
        # "noanim,class:^(xwaylandvideobridge)$"
        # "noinitialfocus,class:^(xwaylandvideobridge)$"
        # "maxsize 1 1,class:^(xwaylandvideobridge)$"
        # "noblur,class:^(xwaylandvideobridge)$"
      ];

      bindm = [

        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      binds = { allow_workspace_cycles = true; };

      bindle = [

        ",XF86MonBrightnessUp,   exec, ${brightnessctl} set +5%"
        ",XF86MonBrightnessDown, exec, ${brightnessctl} set  5%-"
        ",XF86KbdBrightnessUp,   exec, ${brightnessctl} -d asus::kbd_backlight set +1"
        ",XF86KbdBrightnessDown, exec, ${brightnessctl} -d asus::kbd_backlight set  1-"
        ",XF86AudioRaiseVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ +5%"
        ",XF86AudioLowerVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ -5%"
      ];

      bindl = [
        ",XF86AudioPlay,    exec, ${playerctl} play-pause"
        ",XF86AudioStop,    exec, ${playerctl} pause"
        ",XF86AudioPause,   exec, ${playerctl} pause"
        ",XF86AudioPrev,    exec, ${playerctl} previous"
        ",XF86AudioNext,    exec, ${playerctl} next"
        ",XF86AudioMicMute, exec, ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
      ];
    };
  };

  # SCRATCHPADS
  # https://github.com/hyprland-community/pyprland
  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = ["scratchpads", "magnify"]

    [scratchpads.term]
    animation = "fromTop"
    command = "alacritty --class alacritty-dropterm"
    class = "alacritty-dropterm"
    size = "85% 85%"

    [scratchpads.btm]
    animation = "fromTop"
    command = "alacritty --class alacritty-btm -e btm"
    class = "alacritty-btm"
    size = "80% 80%"

    [scratchpads.bitwarden]
    animation = "fromTop"
    command = "bitwarden"
    class = "bitwarden"
    size = "45% 70%"
    unfocus = "hide"

    [scratchpads.volume]
    animation = "fromRight"
    command = "pavucontrol"
    class = "pavucontrol"
    lazy = true
    size = "40% 70%"
    unfocus = "hide"

    [scratchpads.music]
    animation = "fromRight"
    command = "spotify"
    class = "spotify"
    size = "45% 85%"
    unfocus = "hide"

    [scratchpads.filemanager]
    animation = "fromRight"
    command = "nautilus"
    class = "nautilus"
    size = "85% 85%"


    [scratchpads.whatsapp]
    animation = "fromLeft"
    command = "brave --profile-directory=Default --app-id=hnpfjngllnobngcgfapefoaidbinmjnm"
    class = "brave-hnpfjngllnobngcgfapefoaidbinmjnm-Default"
    size = "75% 60%"
    class_match = true
    process_tracking = false 

    [scratchpads.openai]
    animation = "fromLeft"
    command = "brave --profile-directory=Default --app=https://chat.openai.com"
    class = "brave-chat.openai.com__-Default"
    size = "75% 60%"
    process_tracking = false 

    [scratchpads.notion]
    animation = "fromLeft"
    command = "brave --profile-directory=Default --app=https://notion.so"
    class = "brave-notion.so__-Default"
    size = "95% 85%"
    process_tracking = false 
  '';

  home.file.".config/hypr/hyprpaper.conf".text = "\n    preload = "
    + config.stylix.image + ''

      wallpaper = eDP-1,'' + config.stylix.image + ''

        wallpaper = HDMI-A-1,'' + config.stylix.image + ''

          wallpaper = DP-1,'' + config.stylix.image + ''
    ipc = off 
  '';

}
