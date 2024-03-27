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

          "cpu"
          "memory"
          "temperature"
          "disk"

          "hyprland/workspaces"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "idle_inhibitor"
          "tray"
          "keyboard-state"
          "backlight"
          "pulseaudio"
          # "network"
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

    style = lib.mkForce ./waybar.css;

  };

}
