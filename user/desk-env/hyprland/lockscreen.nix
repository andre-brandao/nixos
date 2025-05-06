{ config, ... }:
{

  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 15";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 150;
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
          on-resume = "brightnessctl -rd rgb:kbd_backlight";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 500;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        # {
        #   timeout = 1800;
        #   on-timeout = "systemctl suspend";
        # }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = false;
        grace = 2;
      };
      animations = {
        enabled = true;
        bezier = "linear, 1, 1, 0, 0";
        animation = [
          "fadeIn, 1, 5, linear"
          "fadeOut, 1, 5, linear"
          "inputFieldDots, 1, 2, linear"
        ];
      };
      auth = {
        "pam:enabled" = true;
        # "fingerprint:enabled" = true;
        # "fingerprint:retry_delay" = 250;
        fingerprint = {
            enabled = true;
            retry_delay = 250;
            ready_message = "Scan fingerprint to unlock";
            present_message = "Scanning...";

        };
      };

      background = {
        color = "rgba(25, 20, 20, 1.0)";
        path = "screenshot";
        blur_passes = 2;
        brightness = 0.5;
      };

      label = [
        {
          text = "Hi there $USER";
          color = "rgba(222, 222, 222, 1.0)";
          font_size = 50;
          font_family = "Noto Sans CJK JP";
          position = "0, 70";
          halign = "center";
          valign = "center";
        }
        # {
        #   text = "$TIME";
        #   color = "rgba(222, 222, 222, 1.0)";
        #   font_size = 30;
        #   font_family = "Noto Sans CJK JP";
        #   position = "0, 120";
        #   halign = "center";
        #   valign = "center";
        # }
        # 
        {
           text = "$TIME"; # ref. https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/#variable-substitution
           font_size = 90;       
           position = "-30, 0";
           halign = "right";
           valign = "top";
       }
        {
            # monitor =
            text = ''cmd[update:60000] date +"%A, %d %B %Y"''; # update every 60 seconds
            font_size = 25;
            # font_family = $font;

            position = "-20, -150";
            halign = "right";
            valign = "top";
        }
        {
          # monitor =
          text = "$LAYOUT[en,br]";
          font_size = 24;
          onclick = "hyprctl switchxkblayout all next";

          position = "250, -20";
          halign = "center";
          valign = "center";
        }
        # error message label
        # {
        #   text = "$PAMPROMPT";
        #   color = "rgba(222, 222, 222, 1.0)";
        #   font_size = 30;
        #   font_family = "Noto Sans CJK JP";
        #   position = "0, 10";
        #   halign = "center";
        #   valign = "center";
        # }

        # {
        #   text = "$FPRINTPROMPT";
        #   color = "rgba(222, 222, 222, 1.0)";
        #   font_size = 30;
        #   font_family = "Noto Sans CJK JP";
        #   position = "0, 20";
        #   halign = "center";
        #   valign = "center";
        # }
      ];

      input-field = {
        size = "50, 50";
        dots_size = 0.33;
        dots_spacing = 0.15;
        outer_color = "rgba(25, 20, 20, 0)";
        inner_color = "rgba(25, 20, 20, 0)";
        font_color = "rgba(222, 222, 222, 1.0)";
        placeholder_text = "Password";
        fail_text = "$PAMFAIL";

      };
    };
  };
}
