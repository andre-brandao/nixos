# home.nix

{ inputs, pkgs, lib, config, userSettings, ... }:

{
  imports = [
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    alacritty
    waybar
    kitty
    feh
    swww
    killall
    polkit_gnome
    libva-utils
    gsettings-desktop-schemas
    gnome.zenity
    wlr-randr
    wtype
    ydotool
    wl-clipboard
    hyprland-protocols
    hyprpicker
    swayidle
    swaybg
    fnott
    fuzzel
    keepmenu
    pinentry-gnome3
    wev
    grim
    slurp
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    wlsunset
    pavucontrol
    pamixer
    tesseract4

    hyprpaper
    pyprland
    networkmanagerapplet
  ];

  # gtk.cursorTheme = {
  #   package = pkgs.quintom-cursor-theme;
  #   name = if (config.stylix.polarity == "light") then "Quintom_Ink" else "Quintom_Snow";
  #   size = 36;
  # };

  # programs.rofi = {
  #   enable = true;
  # };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 300;
        offset = "30x50";
        origin = "top-right";
        transparency = 10;
        # frame_color = "#${config.lib.stylix.colors.base08}";
      };
    };
  };


  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;


    settings = {

      exec-once = [
        "pypr"
        "nm-applet --indicator"
        "blueman-applet"
        "${pkgs.waybar}/bin/waybar"
        "${pkgs.dunst}/bin/dunst"
        "dbus-update-activation-environment DISPLAY XAUTHORITY WAYLAND_DISPLAY"
        "hyprctl setcursor  ${config.gtk.cursorTheme.name} ${builtins.toString config.gtk.cursorTheme.size}"
        "hyprpaper"
      ];
      ## See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = "DP-1, 1920x1200, auto, 1";

      xwayland = { force_zero_scaling = true; };

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input = {
        kb_layout = "us";
        kb_variant = "";
        #  kb_model =
        #  kb_options =
        #  kb_rules =

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

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
        drop_shadow = "yes";
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
        "$mainMod, Q, exec, ${userSettings.term}"
        "$mainMod, A, exec, ${userSettings.editor}"

        "$mainMod, T, togglefloating"
        "$mainMod, R, exec, wofi --show drun"
        "$mainMod, P, pseudo" # dwindle
        "$mainMod, S, exec, rofi -show drun -show-icons"

        "$mainMod, C, killactive"

        "$mainMod, E, exec, $fileManager"
        "$mainMod SHIFT, Q, exit"

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
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        "ALT,TAB,cyclenext"

        # Scratchpad
        "$mainMod,Z,exec,pypr toggle term && hyprctl dispatch bringactivetotop"
        "$mainMod,B,exec,pypr toggle btm && hyprctl dispatch bringactivetotop"
        "$mainMod,V,exec,pypr toggle volume && hyprctl dispatch bringactivetotop"
        # "$mainMod,G,exec,pypr toggle gpt && hyprctl dispatch bringactivetotop"
        "$mainMod,W,exec,pypr toggle wpp && hyprctl dispatch bringactivetotop"
      ];
      "$scratchpadsize" = "size 80% 85%";
      "$scratchpad" = "class:^(scratchpad)$";
      windowrulev2 = [
        "float,$scratchpad"
        "$scratchpadsize,$scratchpad"
        "workspace special silent,$scratchpad"
        "center,$scratchpad"
      ];


      bindm = [

        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };

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
    size = "75% 60%"


    [scratchpads.volume]
    animation = "fromRight"
    command = "pavucontrol"
    class = "pavucontrol"
    lazy = true
    size = "50% 90%"
    unfocus = "hide"


    # [scratchpads.gpt]
    # animation = "fromTop"
    # command = "brave --app=https://chat.openai.com/"
    # class = "brave-chat-openai-com"
    # size = "75% 60%"
    # class_match = true

    [scratchpads.wpp]
    animation = "fromLeft"
    command = "brave --profile-directory=Default --app-id=hnpfjngllnobngcgfapefoaidbinmjnm"
    class = "brave-hnpfjngllnobngcgfapefoaidbinmjnm-Default"
    size = "85% 85%"
    process_tracking = false  
  '';

}
