# home.nix

{ inputs, pkgs, lib, config, userSettings, systemSettings, ... }:

{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        margin = "7 7 7 7";
        spacing = 4;

        modules-left = [
          "custom/os"

          "hyprland/workspaces"
        ];
        modules-center = [ ];
        modules-right = [
          "idle_inhibitor"

          "cpu"
          "memory"
          "temperature"
          "disk"

          "tray"
          "keyboard-state"
          "backlight"
          "pulseaudio"
          # "network"
          "clock"
          "battery"
        ];

        # network = {
        #   "format-wifi" = "{essid} ({signalStrength}%) ";
        #   "format-ethernet" = "Connected  ";
        #   "tooltip-format" = "{ifname} via {gwaddr} ";
        #   "format-linked" = "{ifname} (No IP) ";
        #   "format-disconnected" = "Disconnected ⚠";
        #   "format-alt" = "{ifname}= {ipaddr}/{cidr}";
        #   "on-click-right" = "bash ~/.config/rofi/wifi_menu/rofi_wifi_menu";
        # };

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
          "format-icons" = {
            # "1" = "󱚌";
            # "2" = "󰖟";
            # "3" = "";
            # "4" = "󰎄";
            # "5" = "󰋩";
            # "6" = "";
            # "7" = "󰄖";
            # "8" = "󰑴";
            # "9" = "󱎓";
            "scratch_term" = "_";
            # "scratch_ranger" = "_󰴉";
            # "scratch_musikcube" = "_";
            "scratch_btm" = "_";
            # "scratch_geary" = "_";
            "scratch_pavucontrol" = "_󰍰";

            active = "";
            # default = "";
            urgent = "";
          };
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
          "format" = "{:%d-%m-%Y | %I:%M:%S %p}";
          "timezone" = systemSettings.timezone;
          "tooltip-format" = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };

        cpu = { "format" = "{usage}% "; };
        memory = { "format" = "{}% "; };

        "temperature" = {
          # // "thermal-zone": 2,
          "critical-threshold" = 80;
          # // "format-critical"= "{temperatureC}°C {icon}";
          "format" = "{temperatureC}°C {icon}";
          "format-icons" = [ "" ];
        };

        disk = {
          "interval" = 30;
          "format" = "{used}  ";
          "path" = "/";
        };

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
            "pypr toggle volume && hyprctl dispatch bringactivetotop";
        };
      };
    };

    # style = lib.mkForce ./waybar.css;
    style = ''
      @define-color bgDefault #${config.lib.stylix.colors.base00};

      @define-color fgDefault #${config.lib.stylix.colors.base05};

      @define-color fgBlack #${config.lib.stylix.colors.base01};

      @define-color accent #${config.lib.stylix.colors.base08};

      @define-color warning #eb4d4b;
      @define-color bgBatteryCharging #00FA9A;
      @define-color bgBateryCritical #f53c3c;

      * {
        border: none;
        border-radius: 0px;
        font-family: Roboto, Helvetica, Arial, sans-serif;
        font-size: 10px;
        min-height: 0;
      }

      window#waybar {
        background-color: transparent;
        color: @fgDefault;
        transition-property: background-color;
        transition-duration: 0.5s;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      #workspaces button {
        background: @bgDefault;
        color: @fgDefault;
        /* border-radius: 20px; */
      }

      #workspaces button:not(:first-child) {
        margin-left: 1px;
      }

      /* #workspaces button:first-child {
        border-radius: 20px 0px 0px 20px;
      }*/
      #workspaces button:last-child {
        border-radius: 0px 20px 20px 0px;
      }

      #workspaces button:hover {
        background: @accent;
        color: @fgBlack;
        border-bottom: 3px solid @fgDefault;
      }

      #workspaces button.active {
        background: @accent;
        border-bottom: 3px solid @fgDefault;
      }

      /* #workspaces button.focused:hover {
        background: @accent;
        color: @fgBlack;
        border-bottom: 3px solid @fgDefault;
      } */

      #workspaces button.urgent {
        background-color: @warning;
      }

      #mode {
        background-color: @bgDefault;
        border-bottom: 3px solid @fgDefault;
      }

      #clock,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #custom-media,
      #custom-launcher,
      #custom-power,
      #custom-layout,
      #custom-updater,
      #custom-snip,
      #tags,
      #taskbar,
      #tray,
      #idle_inhibitor,
      #mpd,
      #language {
        padding: 0 10px;
        color: @fgDefault;
        background-color: @bgDefault;
      }
      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
        margin-left: 0px;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
        margin-right: 0px;
      }

      #battery {
        padding: 0 10px;
        /* background-color: @fgDefault;
        color: @fgBlack; */
        color: @fgDefault;
        background-color: @bgDefault;
      }

      #battery.charging,
      #battery.plugged {
        color: @fgBlack;
        background-color: @bgBatteryCharging;
      }

      #battery.critical:not(.charging) {
        background-color: @bgBateryCritical;
        color: @fgDefault;
        animation-name: blink;
        animation-duration: 0.8s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #network.disconnected,
      #pulseaudio.muted {
        color: @warning;
      }

      /* #custom-snip {
        color: @colorSkyBlue;
      }



      #tags button.occupied {
        background-color: @bgDefault;
        color: @colorSkyBlue;
      } */

      #idle_inhibitor {
        border-radius: 20px 0px 0px 20px;
      }
      #idle_inhibitor.activated {
        background: @accent;
      }

      #keyboard-state {
        background: #97e1ad;
        color: @fgBlack;
      }

      #tags button.focused {
        background-color: @fgDefault;
        color: @fgBlack;
      }

      #tags button.urgent {
        background-color: @fgDefault;
        color: @warning;
      }

      #temperature.critical {
        background-color: @warning;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }

      @keyframes blink {
        to {
          background-color: @fgDefault;
          color: @fgBlack;
        }
      }

    '';
  };

}
