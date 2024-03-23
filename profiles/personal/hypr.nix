# home.nix

{ inputs, pkgs, lib, config, userSettings, ... }:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''

    ${(pkgs.waybar.override { wireplumberSupport = false; })}/bin/waybar &
     ${pkgs.swww}/bin/swww init &

     ${pkgs.dunst}/bin/dunst 
       
  '';
in
{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      ## See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = "DP-1, 1920x1200, 0x0, 1";

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

        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;

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

        rounding = 10;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };

        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
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
      ];

      bindm = [

        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      exec-once =
        [ "pypr" "${startupScript}/bin/start" "nm-applet" "blueman-applet" ];
    };
  };

  home.packages = with pkgs; [
    alacritty
    kitty
    feh
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
    # (pkgs.writeScriptBin "suspend-unless-render" ''
    #   #!/bin/sh
    #   if pgrep -x nixos-rebuild > /dev/null || pgrep -x home-manager > /dev/null || pgrep -x kdenlive > /dev/null || pgrep -x FL64.exe > /dev/null || pgrep -x blender > /dev/null || pgrep -x flatpak > /dev/null;
    #   then echo "Shouldn't suspend"; sleep 10; else echo "Should suspend"; systemctl suspend; fi
    # '')
    # (pkgs.writeScriptBin "hyprworkspace" ''
    #   #!/bin/sh
    #   # from https://github.com/taylor85345/hyprland-dotfiles/blob/master/hypr/scripts/workspace
    #   monitors=/tmp/hypr/monitors_temp
    #   hyprctl monitors > $monitors

    #   if [[ -z $1 ]]; then
    #     workspace=$(grep -B 5 "focused: no" "$monitors" | awk 'NR==1 {print $3}')
    #   else
    #     workspace=$1
    #   fi

    #   activemonitor=$(grep -B 11 "focused: yes" "$monitors" | awk 'NR==1 {print $2}')
    #   passivemonitor=$(grep  -B 6 "($workspace)" "$monitors" | awk 'NR==1 {print $2}')
    #   #activews=$(grep -A 2 "$activemonitor" "$monitors" | awk 'NR==3 {print $1}' RS='(' FS=')')
    #   passivews=$(grep -A 6 "Monitor $passivemonitor" "$monitors" | awk 'NR==3 {print $1}' RS='(' FS=')')

    #   if [[ $workspace -eq $passivews ]] && [[ $activemonitor != "$passivemonitor" ]]; then
    #    hyprctl dispatch workspace "$workspace" && hyprctl dispatch swapactiveworkspaces "$activemonitor" "$passivemonitor" && hyprctl dispatch workspace "$workspace"
    #     echo $activemonitor $passivemonitor
    #   else
    #     hyprctl dispatch moveworkspacetomonitor "$workspace $activemonitor" && hyprctl dispatch workspace "$workspace"
    #   fi

    #   exit 0

    # '')
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
    package = (pkgs.waybar.override { wireplumberSupport = false; });
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        margin = "7 7 3 7";
        spacing = 2;

        modules-left = [
          "custom/os"
          "battery"
          "backlight"
          "keyboard-state"
          "pulseaudio"
          "cpu"
          "memory"
        ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [ "idle_inhibitor" "tray" "clock" ];

        "custom/os" = {
          "format" = " {} ";
          "exec" = ''echo "" '';
          "interval" = "once";
        };
        "custom/hyprprofile" = {
          "format" = "   {}";
          "exec" = "cat ~/.hyprprofile";
          "interval" = 3;
          "on-click" = "hyprprofile-dmenu";
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
          "format-icons" = {
            "1" = "󱚌";
            "2" = "󰖟";
            "3" = "";
            "4" = "󰎄";
            "5" = "󰋩";
            "6" = "";
            "7" = "󰄖";
            "8" = "󰑴";
            "9" = "󱎓";
            "scratch_term" = "_";
            "scratch_ranger" = "_󰴉";
            "scratch_musikcube" = "_";
            "scratch_btm" = "_";
            "scratch_geary" = "_";
            "scratch_pavucontrol" = "_󰍰";
          };
          "on-click" = "activate";
          "on-scroll-up" = "hyprctl dispatch workspace e+1";
          "on-scroll-down" = "hyprctl dispatch workspace e-1";
          #"all-outputs" = true;
          #"active-only" = true;
          "ignore-workspaces" = [ "scratch" "-" ];
          #"show-special" = false;
          #"persistent-workspaces" = {
          #    # this block doesn't seem to work for whatever reason
          #    "eDP-1" = [1 2 3 4 5 6 7 8 9];
          #    "DP-1" = [1 2 3 4 5 6 7 8 9];
          #    "HDMI-A-1" = [1 2 3 4 5 6 7 8 9];
          #    "1" = ["eDP-1" "DP-1" "HDMI-A-1"];
          #    "2" = ["eDP-1" "DP-1" "HDMI-A-1"];
          #    "3" = ["eDP-1" "DP-1" "HDMI-A-1"];
          #    "4" = ["eDP-1" "DP-1" "HDMI-A-1"];
          #    "5" = ["eDP-1" "DP-1" "HDMI-A-1"];
          #    "6" = ["eDP-1" "DP-1" "HDMI-A-1"];
          #    "7" = ["eDP-1" "DP-1" "HDMI-A-1"];
          #    "8" = ["eDP-1" "DP-1" "HDMI-A-1"];
          #    "9" = ["eDP-1" "DP-1" "HDMI-A-1"];
          #};
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
    style = ''
      * {
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: FontAwesome, '' + userSettings.font + ''
      ;

                font-size: 13px;
            }

            window#waybar {
                background-color: #'' + config.lib.stylix.colors.base00 + ''
      ;
                opacity: 0.75;
                border-radius: 8px;
                color: #'' + config.lib.stylix.colors.base07 + ''
      ;
                transition-property: background-color;
                transition-duration: .2s;
            }

            window > box {
                border-radius: 8px;
                opacity: 0.94;
            }

            window#waybar.hidden {
                opacity: 0.2;
            }

            button {
                border: none;
            }

            #custom-hyprprofile {
                color: #'' + config.lib.stylix.colors.base0D + ''
      ;
            }

            /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
            button:hover {
                background: inherit;
            }

            #workspaces button {
                padding: 0 7px;
                background-color: transparent;
                color: #'' + config.lib.stylix.colors.base04 + ''
      ;
            }

            #workspaces button:hover {
                color: #'' + config.lib.stylix.colors.base07 + ''
      ;
            }

            #workspaces button.active {
                color: #'' + config.lib.stylix.colors.base08 + ''
      ;
            }

            #workspaces button.focused {
                color: #'' + config.lib.stylix.colors.base0A + ''
      ;
            }

            #workspaces button.visible {
                color: #'' + config.lib.stylix.colors.base05
    + ''
      ;
            }

            #workspaces button.urgent {
                color: #'' + config.lib.stylix.colors.base09 + ''
      ;
            }

            #clock,
            #battery,
            #cpu,
            #memory,
            #disk,
            #temperature,
            #backlight,
            #network,
            #pulseaudio,
            #wireplumber,
            #custom-media,
            #tray,
            #mode,
            #idle_inhibitor,
            #scratchpad,
            #mpd {
                padding: 0 10px;
                color: #'' + config.lib.stylix.colors.base07 + ''
      ;
                border: none;
                border-radius: 8px;
            }

            #window,
            #workspaces {
                margin: 0 4px;
            }

            /* If workspaces is the leftmost module, omit left margin */
            .modules-left > widget:first-child > #workspaces {
                margin-left: 0;
            }

            /* If workspaces is the rightmost module, omit right margin */
            .modules-right > widget:last-child > #workspaces {
                margin-right: 0;
            }

            #clock {
                color: #'' + config.lib.stylix.colors.base0D + ''
      ;
            }

            #battery {
                color: #'' + config.lib.stylix.colors.base0B + ''
      ;
            }

            #battery.charging, #battery.plugged {
                color: #'' + config.lib.stylix.colors.base0C + ''
      ;
            }

            @keyframes blink {
                to {
                    background-color: #''
    + config.lib.stylix.colors.base07 + ''
      ;
                    color: #'' + config.lib.stylix.colors.base00 + ''
      ;
                }
            }

            #battery.critical:not(.charging) {
                background-color: #'' + config.lib.stylix.colors.base08 + ''
      ;
                color: #'' + config.lib.stylix.colors.base07 + ''
      ;
                animation-name: blink;
                animation-duration: 0.5s;
                animation-timing-function: linear;
                animation-iteration-count: infinite;
                animation-direction: alternate;
            }

            label:focus {
                background-color: #'' + config.lib.stylix.colors.base00
    + ''
      ;
            }

            #cpu {
                color: #'' + config.lib.stylix.colors.base0D + ''
      ;
            }

            #memory {
                color: #'' + config.lib.stylix.colors.base0E + ''
      ;
            }

            #disk {
                color: #'' + config.lib.stylix.colors.base0F + ''
      ;
            }

            #backlight {
                color: #'' + config.lib.stylix.colors.base0A + ''
      ;
            }

            label.numlock {
                color: #'' + config.lib.stylix.colors.base04 + ''
      ;
            }

            label.numlock.locked {
                color: #'' + config.lib.stylix.colors.base0F + ''
      ;
            }

            #pulseaudio {
                color: #'' + config.lib.stylix.colors.base0C + ''
      ;
            }

            #pulseaudio.muted {
                color: #'' + config.lib.stylix.colors.base04
    + ''
      ;
            }

            #tray > .passive {
                -gtk-icon-effect: dim;
            }

            #tray > .needs-attention {
                -gtk-icon-effect: highlight;
            }

            #idle_inhibitor {
                color: #'' + config.lib.stylix.colors.base04 + ''
      ;
            }

            #idle_inhibitor.activated {
                color: #'' + config.lib.stylix.colors.base0F + ''
      ;
            }
    '';
  };

}
