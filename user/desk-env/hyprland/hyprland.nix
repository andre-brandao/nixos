# home.nix

{ inputs, pkgs, lib, config, userSettings, ... }:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''


    ${pkgs.swww}/bin/swww init &

    ${pkgs.swww}/bin/swww ${../../../themes} &
    1
    ${pkgs.waybar}/bin/waybar &

    ${pkgs.dunst}/bin/dunst 
      
  '';
in
{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
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
        "$mainMod, J, togglesplit" # dwindle
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

        #  bind=SUPER,Z,exec,pypr toggle term && hyprctl dispatch bringactivetotop
        #  bind=SUPER,F,exec,pypr toggle ranger && hyprctl dispatch bringactivetotop
        #  bind=SUPER,N,exec,pypr toggle musikcube && hyprctl dispatch bringactivetotop
        #  bind=SUPER,B,exec,pypr toggle btm && hyprctl dispatch bringactivetotop
        #  bind=SUPER,E,exec,pypr toggle geary && hyprctl dispatch bringactivetotop
        #  bind=SUPER,code:172,exec,pypr toggle pavucontrol && hyprctl dispatch bringactivetotop
        #  $scratchpadsize = size 80% 85%
      ];

      #  $scratchpad = class:^(scratchpad)$
      #  windowrulev2 = float,$scratchpad
      #  windowrulev2 = $scratchpadsize,$scratchpad
      #  windowrulev2 = workspace special silent,$scratchpad
      #  windowrulev2 = center,$scratchpad

      bindm = [

        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      exec-once = [
        "pypr"
        "${startupScript}/bin/start"
        # "nm-applet"
        # "blueman-applet"
        # "waybar"
      ];
    };
  };

  home.packages = with pkgs; [
    alacritty
    waybar
    kitty
    feh
    swww
    rofi
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
    (pkgs.writeScriptBin "screenshot-ocr" ''
      #!/bin/sh
      imgname="/tmp/screenshot-ocr-$(date +%Y%m%d%H%M%S).png"
      txtname="/tmp/screenshot-ocr-$(date +%Y%m%d%H%M%S)"
      txtfname=$txtname.txt
      grim -g "$(slurp)" $imgname;
      tesseract $imgname $txtname;
      wl-copy -n < $txtfname
    '')
    (pkgs.writeScriptBin "sct" ''
      #!/bin/sh
      killall wlsunset &> /dev/null;
      if [ $# -eq 1 ]; then
        temphigh=$(( $1 + 1 ))
        templow=$1
        wlsunset -t $templow -T $temphigh &> /dev/null &
      else
        killall wlsunset &> /dev/null;
      fi
    '')
    (pkgs.python3Packages.buildPythonPackage rec {
      pname = "pyprland";
      version = "1.4.1";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "sha256-JRxUn4uibkl9tyOe68YuHuJKwtJS//Pmi16el5gL9n8=";
      };
      format = "pyproject";
      propagatedBuildInputs = with pkgs; [
        python3Packages.setuptools
        python3Packages.poetry-core
        poetry
      ];
      doCheck = false;
    })
  ];

  home.file.".config/hypr/pyprland.json".text = ''
    {
      "pyprland": {
        "plugins": ["scratchpads", "magnify"]
      },
      "scratchpads": {
        "term": {
          "command": "alacritty --class scratchpad",
          "margin": 50
        },
        "ranger": {
          "command": "kitty --class scratchpad -e ranger",
          "margin": 50
        },
        "musikcube": {
          "command": "alacritty --class scratchpad -e musikcube",
          "margin": 50
        },
        "btm": {
          "command": "alacritty --class scratchpad -e btm",
          "margin": 50
        },
        "geary": {
          "command": "geary",
          "margin": 50
        },
        "pavucontrol": {
          "command": "pavucontrol",
          "margin": 50,
          "unfocus": "hide",
          "animation": "fromTop"
        }
      }
    }
  '';

  # pkgs.waybar.overrideAttrs (oldAttrs: {
  #       postPatch = ''
  #         # use hyprctl to switch workspaces
  #         sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprworkspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp
  #         sed -i 's/gIPC->getSocket1Reply("dispatch workspace " + std::to_string(id()));/const std::string command = "hyprworkspace " + std::to_string(id());\n\tsystem(command.c_str());/g' src/modules/hyprland/workspaces.cpp
  #       '';
  #       wireplumberSupport = false; # Disable wireplumber support
  #     })
  programs.waybar = {
    enable = true;
    # package = (pkgs.waybar.override { wireplumberSupport = false; });
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        margin = "7 7 7 7";
        spacing = 4;

        modules-left = [ "custom/os" "hyprland/workspaces" ];
        modules-center = [ ];
        modules-right = [
          "idle_inhibitor"
          "tray"
          "clock"

          "backlight"
          "keyboard-state"
          "pulseaudio"

          "cpu"
          "memory"
          "battery"
        ];

        "custom/os" = {
          "format" = " {} ";
          "exec" = ''echo "" '';
          "interval" = "once";
        };
        "keyboard-state" = {
          "numlock" = true;
          "format" = " {icon} ";
          "format-icons" = {
            "locked" = "󰎠";
            "unlocked" = "󱧓";
          };
        };
        "hyprland/workspaces" = {
          "format" = "{icon}";
          # "format-icons" = {
          #   "1" = "󱚌";
          #   "2" = "󰖟";
          #   "3" = "";
          #   "4" = "󰎄";
          #   "5" = "󰋩";
          #   "6" = "";
          #   "7" = "󰄖";
          #   "8" = "󰑴";
          #   "9" = "󱎓";
          #   "scratch_term" = "_";
          #   "scratch_ranger" = "_󰴉";
          #   "scratch_musikcube" = "_";
          #   "scratch_btm" = "_";
          #   "scratch_geary" = "_";
          #   "scratch_pavucontrol" = "_󰍰";
          # };
          "on-click" = "activate";
          "on-scroll-up" = "hyprctl dispatch workspace e+1";
          "on-scroll-down" = "hyprctl dispatch workspace e-1";
          #"all-outputs" = true;
          #"active-only" = true;
          "ignore-workspaces" = [ "scratch" "-" ];
          #"show-special" = false;
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
        };
        tray = {
          #"icon-size" = 21;
          "spacing" = 10;
        };
        clock = {
          "interval" = 1;
          "format" = "{:%a %Y-%m-%d %I:%M:%S %p}";
          "timezone" = "America/Chicago";
          "tooltip-format" = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        cpu = { "format" = "{usage}% "; };
        memory = { "format" = "{}% "; };
        backlight = {
          "format" = "{percent}% {icon}";
          "format-icons" = [ "" "" "" "" "" "" "" "" "" ];
        };
        battery = {
          "states" = {
            "good" = 95;
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{capacity}% {icon}";
          "format-charging" = "{capacity}% ";
          "format-plugged" = "{capacity}% ";
          #"format-good" = ""; # An empty format will hide the module
          #"format-full" = "";
          "format-icons" = [ "" "" "" "" "" ];
        };
        pulseaudio = {
          "scroll-step" = 1;
          "format" = "{volume}% {icon}  {format_source}";
          "format-bluetooth" = "{volume}% {icon}  {format_source}";
          "format-bluetooth-muted" = "󰸈 {icon}  {format_source}";
          "format-muted" = "󰸈 {format_source}";
          "format-source" = "{volume}% ";
          "format-source-muted" = " ";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [ "" "" "" ];
          };
          "on-click" =
            "pypr toggle pavucontrol && hyprctl dispatch bringactivetotop";
        };
      };
    };

    style = ./waybar.css;
    # style = ''
    #       * {
    #       border: none;
    #       border-radius: 0px;
    #       /* `otf-font-awesome` is required to be installed for icons */
    #       font-family: Roboto, Helvetica, Arial, sans-serif;
    #       font-size: 13px;
    #       min-height: 0;
    #   }

    #   window#waybar {
    #       background-color: transparent;
    #       color: #ffffff;
    #       transition-property: background-color;
    #       transition-duration: .5s;
    #   }

    #   window#waybar.hidden {
    #       opacity: 0.2;
    #   }


    #   #workspaces button {
    #       background: #1f1f1f;
    #       color: #ffffff;
    #       border-radius: 20px;

    #   }

    #   /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
    #   #workspaces button:hover {
    #       background: lightblue;
    #       color: black;
    #       border-bottom: 3px solid #ffffff;

    #   }

    #   #workspaces button.focused {
    #       background: #1f1f1f;
    #   }

    #   #workspaces button.focused:hover {
    #       background: lightblue;
    #       color: black;
    #       border-bottom: 3px solid #ffffff;

    #   }

    #   #workspaces button.urgent {
    #       background-color: #eb4d4b;
    #   }

    #   #mode {
    #       background-color: #64727D;
    #       border-bottom: 3px solid #ffffff;
    #   }

    #   #clock,
    #   #battery,
    #   #cpu,
    #   #memory,
    #   #disk,
    #   #temperature,
    #   #backlight,
    #   #network,
    #   #pulseaudio,
    #   #custom-media,
    #   #custom-launcher,
    #   #custom-power,
    #   #custom-layout,
    #   #custom-updater,
    #   #custom-snip,
    #   #custom-wallpaper,
    #   #tags,
    #   #taskbar,
    #   #tray,
    #   #mode,
    #   #idle_inhibitor,
    #   #mpd {
    #       padding: 0 10px;
    #       color: #ffffff;
    #   }

    #   #window,
    #   #workspaces {
    #       margin: 0px 4px;
    #   }

    #   /* If workspaces is the leftmost module, omit left margin */
    #   .modules-left > widget:first-child > #workspaces {
    #       margin-left: 0px;
    #   }

    #   /* If workspaces is the rightmost module, omit right margin */
    #   .modules-right > widget:last-child > #workspaces {
    #       margin-right: 0px;
    #   }

    #   #clock {
    #       background-color: #171717;
    #       color: #ffffff;
    #   }

    #   #battery {
    #       background-color: #ffffff;
    #       color: #000000;
    #   }

    #   #battery.charging, #battery.plugged {
    #       color: #ffffff;
    #       background-color: #26A65B;
    #   }

    #   @keyframes blink {
    #       to {
    #           background-color: #ffffff;
    #           color: #000000;
    #       }
    #   }

    #   #battery.critical:not(.charging) {
    #       background-color: #f53c3c;
    #       color: #ffffff;
    #       animation-name: blink;
    #       animation-duration: 0.5s;
    #       animation-timing-function: linear;
    #       animation-iteration-count: infinite;
    #       animation-direction: alternate;
    #   }

    #   label:focus {
    #       background-color: #000000;
    #   }

    #   #cpu {
    #       background-color: #171717;
    #       color: #ffffff;
    #   }

    #   #memory {
    #       background-color: #171717;
    #       color: #ffffff;
    #   }

    #   #disk {
    #       background-color: #171717;
    #       color: #ffffff;
    #   }

    #   #backlight {
    #       background-color: #90b1b1;
    #   }

    #   #network {
    #       background-color: #171717;
    #       color: #ffffff;
    #   }

    #   #network.disconnected {
    #       background-color: #171717;
    #       color: red;
    #   }

    #   #pulseaudio {
    #       background-color: #171717;
    #       color: #ffffff;
    #   }

    #   #pulseaudio.muted {
    #       background-color: #171717;
    #       color: red;
    #   }

    #   #custom-media {
    #       background-color: #171717;
    #       color: white;
    #   }

    #   #custom-media.custom-spotify {
    #       background-color: #171717;
    #       color: white;

    #   }

    #   #custom-media.custom-vlc {
    #       background-color: #171717;
    #       color: white;
    #   }

    #   #custom-power{
    #       background-color: #171717;
    #       font-size: 18px;
    #       margin-right: 5px;

    #   }

    #   #custom-launcher{
    #       background-color: #171717;
    #       font-size: 20px;
    #       margin-left: 5px;

    #   }

    #   #custom-layout{
    #       background-color: #171717;
    #       color: white;
    #       font-size:20px;
    #   }

    #   #custom-updater {
    #       background-color: #171717;
    #       color: white;
    #   }

    #   #custom-snip {
    #       background-color: #171717;
    #       color: skyblue;
    #       font-size: 20px;
    #   }

    #   #custom-wallpaper {
    #       background-color: #171717;
    #       color: pink;
    #       font-size: 20px;
    #   }

    #   #tags{
    #       background-color: #171717;
    #       font-size: 20px;
    #   }

    #   #tags button.occupied {
    #       color: skyblue;
    #       margin: 5px;
    #       background-color: #272727;
    #   }
    #   #tags button.focused {
    #       color: black;
    #       margin: 5px;
    #       background-color: white;
    #   }
    #   #tags button.urgent{
    #       color: red;
    #       margin: 5px;
    #       background-color:white;
    #   }


    #   #taskbar{
    #       background-color: #171717;
    #       border-radius: 0px 20px 20px 0px;
    #   }

    #   #temperature {
    #       background-color: #171717;
    #       color: #ffffff;
    #   }

    #   #temperature.critical {
    #       background-color: #eb4d4b;
    #   }

    #   #tray {
    #       background-color: #171717;
    #       color: #ffffff;
    #   }

    #   #tray > .passive {
    #       -gtk-icon-effect: dim;
    #       background-color: #171717;
    #       color: #ffffff;
    #   }

    #   #tray > .needs-attention {
    #       -gtk-icon-effect: highlight;
    #       background-color: #171717;
    #       color: #ffffff;
    #   }

    #   #idle_inhibitor {
    #       background-color: #171717;
    #       border-radius: 20px 0px 0px 20px;

    #   }

    #   #idle_inhibitor.activated {
    #       background-color: #171717;
    #       color: #ffffff;
    #       border-radius: 20px 0px 0px 20px;

    #   }

    #   #language {
    #       background-color: #171717;
    #       color: #ffffff;
    #       min-width: 16px;
    #   }

    #   #keyboard-state {
    #       background: #97e1ad;
    #       color: #000000;
    #       min-width: 16px;
    #   }

    #   #keyboard-state > label {
    #       padding: 0px 5px;
    #   }

    #   #keyboard-state > label.locked {
    #       background: rgba(0, 0, 0, 0.2);
    #   }



    # '';

  };

}
