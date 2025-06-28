# home.nix

{
  inputs,
  pkgs,
  lib,
  config,
  userSettings,
  systemSettings,
  ...
}:

{
  home.packages = with pkgs; [
    nvd
    (writeShellScriptBin "update-checker" ''
       #This script assumes your flake is in ~/.dotfiles and that your flake's nixosConfigurations is named the same as your $hostname
       updates="$(cd ~/dotfiles/nixos && nix flake update nixpkgs && nix build .#nixosConfigurations.system.config.system.build.toplevel --option max-jobs 2 && nvd diff /run/current-system ./result | grep -e '\[U' | wc -l)"

       alt="has-updates"
       if [ $updates -eq 0 ]; then
           alt="updated"
       fi

       tooltip="System updated"
       if [ $updates != 0 ]; then
      	    tooltip=$(cd ~/dotfiles/nixos && nvd diff /run/current-system ./result | grep -e '\[U' | awk '{ for (i=3; i<NF; i++) printf $i " "; if (NF >= 3) print $NF; }' ORS='\\n' )
       fi

       echo "{ \"text\":\"$updates\", \"alt\":\"$alt\", \"tooltip\":\"$tooltip\" }"
    '')
  ];
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    package = pkgs.waybar;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 31;
        margin = "7 7 7 7";
        spacing = 4;

        modules-left = [
          "custom/os"
          "custom/nix-updates"
          "cpu"
          "memory"
          "disk"
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [
          "clock"
          "privacy"
        ];
        modules-right = [
          "idle_inhibitor"

          "hyprland/language"

          # "temperature"
          "custom/notification"
          "tray"
          "group/backlight"
          "group/pulseaudio"
          "bluetooth"
          "network"
          "group/power"
        ];

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
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        "power-profiles-daemon" = {
          "format" = "{icon}";
          "tooltip-format" = "Power profile= {profile}\nDriver= {driver}";
          "tooltip" = true;
          "format-icons" = {
            "default" = "";
            "performance" = "";
            "balanced" = "";
            "power-saver" = "";
          };
        };

        "group/power" = {
          orientation = "horizontal";
          "drawer" = {
            "transition-duration" = 250;
            "children-class" = "drawer";
            "transition-left-to-right" = false;
          };
          modules = [
            "battery"
            "power-profiles-daemon"
            "custom/quit"
            "custom/lock"
            "custom/reboot"
            "custom/power" # // First element is the "group leader" and won't ever be hidden
          ];
        };

        "custom/quit" = {
          "format" = "󰗼";
          "tooltip" = "Quit";
          "on-click" = "hyprctl dispatch exit";
        };
        "custom/lock" = {
          "format" = "󰍁";
          "tooltip" = "Lock";
          "on-click" = "hyprlock";
        };
        "custom/reboot" = {
          "format" = "󰜉";
          "tooltip" = "Reboot";
          "on-click" = "reboot";
        };
        "custom/power" = {
          "format" = " ";
          "tooltip" = "Power off";
          "on-click" = "shutdown now";
        };

        "custom/os" = {
          "format" = " {} ";
          "exec" = ''echo " " '';
          "interval" = "once";
        };
        "custom/nix-updates" =
          let
            update-checker = "${(pkgs.writeShellScriptBin "update-checker" ''
               #This script assumes your flake is in ~/.dotfiles and that your flake's nixosConfigurations is named the same as your $hostname
               updates="$(cd ~/dotfiles/nixos && nix flake update nixpkgs && nix build .#nixosConfigurations.system.config.system.build.toplevel --option max-jobs 2 && ${pkgs.nvd}/bin/nvd diff /run/current-system ./result | grep -e '\[U' | wc -l)"

               alt="has-updates"
               if [ $updates -eq 0 ]; then
                   alt="updated"
               fi

               tooltip="System updated"
               if [ $updates != 0 ]; then
              	    tooltip=$(cd ~/dotfiles/nixos && ${pkgs.nvd}/bin/nvd diff /run/current-system ./result | grep -e '\[U' | ${pkgs.gawk}/bin/awk '{ for (i=3; i<NF; i++) printf $i " "; if (NF >= 3) print $NF; }' ORS='\\n' )
               fi

               echo "{ \"text\":\"$updates\", \"alt\":\"$alt\", \"tooltip\":\"$tooltip\" }"
            '')}/bin/update-checker";
          in
          {
            "exec" = update-checker; # <--- path to script
            "on-click" = "${update-checker} && notify-send 'The system has been updated'"; # refresh on click
            "interval" = 3600; # refresh every hour
            "tooltip" = true;
            "return-type" = "json";
            "format" = "{} {icon}";
            "format-icons" = {
              "has-updates" = ""; # icon when updates needed
              "updated" = ""; # icon when all packages updated
            };
          };

        "custom/notification" = {
          "tooltip" = false;
          "format" = "{icon}";
          "format-icons" = {
            "notification" = "<span foreground='red'><sup></sup></span>";
            "none" = "";
            "dnd-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-none" = "";
            "inhibited-notification" = "<span foreground='red'><sup></sup></span>";
            "inhibited-none" = "";
            "dnd-inhibited-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-inhibited-none" = "";
          };
          "return-type" = "json";
          "exec-if" = "which swaync-client";
          "exec" = "swaync-client -swb";
          "on-click" = "swaync-client -t -sw";
          "on-click-right" = "swaync-client -d -sw";
          "escape" = true;
        };
        "hyprland/workspaces" = {
          "format" = "{icon}";
          "format-icons" = {
            # "1": "",
            # "2": "",
            # "3": "",
            # "4": "",
            # "5": "",
            # "active": "",
            # "default": ""
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

          "hyprland/language" = {
            "format" = "{} 󰌌 ";

            "format-en" = "us";
            "format-br" = "br";
          };
          "on-click" = "activate";
          "on-scroll-up" = "hyprctl dispatch workspace e+1";
          "on-scroll-down" = "hyprctl dispatch workspace e-1";
          #"all-outputs" = true;
          #"active-only" = true;
          "ignore-workspaces" = [
            "scratch"
            "-"
          ];
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
          show-passive-items = true;
        };
        clock = {
          "interval" = 1;
          "format" = "{:%d/%m | %I:%M:%S %p}";
          "timezone" = systemSettings.timezone;
          "tooltip-format" = ''
            <big>{:%Y %B}</big>

            <tt><small>{calendar}</small></tt>'';
          "calendar" = {
            "mode" = "year";
            "mode-mon-col" = 3;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            "on-click-right" = "mode";
            "format" = {
              "months" = "<span color='#ffead3'><b>{}</b></span>";
              "days" = "<span color='#ecc6d9'><b>{}</b></span>";
              "weeks" = "<span color='#99ffdd'><b>W{}</b></span>";
              "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
              "today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          "actions" = {
            "on-click-right" = "mode";
            "on-click-forward" = "tz_up";
            "on-click-backward" = "tz_down";
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
          };
        };

        cpu = {
          "format" = "{usage}%  ";
          "interval" = 2;
        };
        memory = {
          "format" = "{}% ";
          "interval" = 2;
        };

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

        "group/backlight" = {
          orientation = "horizontal";
          "drawer" = {
            "transition-duration" = 250;
            "children-class" = "drawer";
            "transition-left-to-right" = false;
          };
          modules = [
            "backlight"
            "backlight/slider"
          ];
        };

        backlight = {
          "format" = "{percent}% {icon}";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "backlight/slider" = {
          "min" = 0;
          "max" = 100;
          "orientation" = "horizontal";
          "device" = "intel_backlight";
        };

        "group/pulseaudio" = {
          orientation = "horizontal";
          "drawer" = {
            "transition-duration" = 250;
            "children-class" = "drawer";
            "transition-left-to-right" = false;
          };
          modules = [
            "pulseaudio"
            "pulseaudio/slider"
          ];
        };

        pulseaudio = {
          "scroll-step" = 1;
          "format" = "{volume}% {icon}  {format_source}";
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
            "default" = [
              ""
              ""
              ""
            ];
          };
          "tooltip-format" = "{volume}% {icon}  {format_source}";
          "on-click" = "pypr toggle volume && hyprctl dispatch bringactivetotop";
        };
        "pulseaudio/slider" = {
          "min" = 0;
          "max" = 100;
          "orientation" = "horizontal";
        };

        bluetooth = {
          "format" = " {status}";
          "format-disabled" = "";
          "format-connected" = " {num_connections} ";
          # "format-connected" = " {device_alias}";
          # "format-connected-battery" = " {device_alias} {device_battery_percentage}%";
          "tooltip-format" = "{controller_alias}\t{controller_address}";
          "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
          on-click = "pypr toggle bluetooth && hyprctl dispatch bringactivetotop";
        };

        network = {
          "format-wifi" = "({signalStrength}%)  ";
          "format-ethernet" = "Connected  ";
          "tooltip-format" = "{ifname} via {gwaddr} ";
          "format-linked" = "{ifname} (No IP) ";
          "format-disconnected" = "Disconnected ⚠";
          # "format-alt" = "{ifname}= {ipaddr}/{cidr}";
          "on-click" = "pypr toggle network && hyprctl dispatch bringactivetotop";
        };

        privacy = {
          "icon-spacing" = 4;
          "icon-size" = 18;
          "transition-duration" = 250;
          "modules" = [
            {
              "type" = "screenshare";
              "tooltip" = true;
              "tooltip-icon-size" = 24;
            }
            {
              "type" = "audio-out";
              "tooltip" = true;
              "tooltip-icon-size" = 24;
            }
            {
              "type" = "audio-in";
              "tooltip" = true;
              "tooltip-icon-size" = 24;
            }
          ];
        };
      };
    };

    # style = lib.mkForce ./waybar.css;
    style = with config.lib.stylix.colors.withHashtag; ''

      @define-color base00 ${base00}; @define-color base01 ${base01}; @define-color base02 ${base02}; @define-color base03 ${base03};
      @define-color base04 ${base04}; @define-color base05 ${base05}; @define-color base06 ${base06}; @define-color base07 ${base07};

      @define-color base08 ${base08}; @define-color base09 ${base09}; @define-color base0A ${base0A}; @define-color base0B ${base0B};
      @define-color base0C ${base0C}; @define-color base0D ${base0D}; @define-color base0E ${base0E}; @define-color base0F ${base0F};

       @define-color bgDefault ${base00};

       @define-color fgDefault ${base05};

       @define-color fgBlack ${base01};

       @define-color accent ${base08};

       @define-color accent2 ${base09};

       @define-color warning #eb4d4b;
       @define-color bgBatteryCharging #00FA9A;
       @define-color bgBateryCritical #f53c3c;

       * {
         border: none;
         border-radius: 0px;
         font-family: Roboto, Helvetica, Arial, sans-serif;
         font-size: 14px;
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

       #workspaces button:first-child {
         border-radius: 5px 0px 0px 5px;
       }
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
         border-top: 3px solid @fgDefault;
         border-bottom: 3px solid @fgDefault;
       }

      #power-profiles-daemon,
      #custom-power,
      #custom-quit,
      #custom-lock,
      #custom-reboot
      {
        padding: 0 10px;
        border-radius: 5px;
        margin: 0 2px;
      }
      #power-profiles-daemon.performance {
         background-color: #e79675;
         color: @fgBlack;
       }
      #power-profiles-daemon.balanced {
         background-color: lightblue;
         color: @fgBlack;
      }
      #power-profiles-daemon.power-saver {
        background-color: #b4f4a1;
        color: @fgBlack;
      }
      #custom-power {
        color: @fgDefault;
        background-color: red;
      }
      #custom-quit {
        color: @fgBlack;
        background-color: #dccb7a;
      }
      #custom-lock {
        color: @fgDefault;
        background-color: @fgBlack;
      }
      #custom-reboot {
        color: @fgBlack;
        background-color: #e37a80;
      }



      slider {
        background-color: @accent;
        border-radius: 15px;
      }
      trough {
        min-width: 80px;
        min-height: 5px;
        border-radius: 5px;
        background-color: @accent2;
      }
      highlight {
        min-width: 10px;
        border-radius: 5px;
        background-color: @accent;
      }



       #privacy,
       #clock,
       #bluetooth,
       #cpu,
       #memory,
       #disk,
       #temperature,
       #backlight,
       #network,
       #pulseaudio,
       #tags,
       #taskbar,
       #tray,
       #idle_inhibitor,
       #custom-notification,
       #custom-nix-updates,
       #mpd,
       #language {
         padding: 0 10px;
         color: @fgDefault;
         background-color: @bgDefault;
         border-radius: 5px;
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
         border-radius: 5px;
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
         animation-duration: 0.4s;
         animation-timing-function: linear;
         animation-iteration-count: infinite;
         animation-direction: alternate;
       }

       #network.disconnected,
       #pulseaudio.muted {
         color: @warning;
       }


       #idle_inhibitor {
         border-radius: 20px 5px 5px 20px;
       }

       #idle_inhibitor.activated {
         background: @accent;
         color: @fgBlack;
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
