{ config, ... }:
{

  # services.hypridle = {
  #   enable = true;

  #   settings = {
  #     general = {
  #       lock_cmd = "pidof hyprlock || hyprlock";
  #       before_sleep_cmd = "loginctl lock-session";
  #       after_sleep_cmd = "hyprctl dispatch dpms on";
  #     };

  #     listener = [
  #       {
  #         timeout = 150;
  #         on-timeout = "brightnessctl -s set 15";
  #         on-resume = "brightnessctl -r";
  #       }
  #       {
  #         timeout = 150;
  #         on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
  #         on-resume = "brightnessctl -rd rgb:kbd_backlight";
  #       }
  #       {
  #         timeout = 300;
  #         on-timeout = "loginctl lock-session";
  #       }
  #       {
  #         timeout = 380;
  #         on-timeout = "hyprctl dispatch dpms off";
  #         on-resume = "hyprctl dispatch dpms on";
  #       }
  #       {
  #         timeout = 1800;
  #         on-timeout = "systemctl suspend";
  #       }
  #     ];
  #   };
  # };

  # home.file.".config/hypr/hyprlock.conf".text = ''
  #   background {
  #       monitor =
  #       path = ${config.stylix.image}   # only png supported for now
  #   }

  #   label {
  #       monitor =
  #       text = cmd[update:1000] echo "$TIME"
  #       color = rgba(200, 200, 200, 1.0)
  #       font_size = 55
  #       font_family = Fira Semibold
  #       position = -100, -200
  #       halign = right
  #       valign = bottom
  #       shadow_passes = 5
  #       shadow_size = 10
  #   }

  #   label {
  #       monitor =
  #       text = $USER
  #       color = rgba(200, 200, 200, 1.0)
  #       font_size = 20
  #       font_family = Fira Semibold
  #       position = -100, 160
  #       halign = right
  #       valign = bottom
  #       shadow_passes = 5
  #       shadow_size = 10
  #   }


  #   input-field {
  #       monitor =
  #       size = 200, 50
  #       outline_thickness = 3
  #       dots_size = 0.33 # Scale of input-field height, 0.2 - 0.8
  #       dots_spacing = 0.15 # Scale of dots' absolute size, 0.0 - 1.0
  #       dots_center = false
  #       dots_rounding = -1 # -1 default circle, -2 follow input-field rounding
  #       outer_color = rgb(151515)
  #       inner_color = rgb(200, 200, 200)
  #       font_color = rgb(10, 10, 10)
  #       fade_on_empty = true
  #       fade_timeout = 1000 # Milliseconds before fade_on_empty is triggered.
  #       # placeholder_text = <i>Input Password...</i> # Text rendered in the input box when it's empty.
  #       hide_input = false
  #       rounding = -1 # -1 means complete rounding (circle/oval)
  #       check_color = rgb(204, 136, 34)
  #       fail_color = rgb(204, 34, 34) # if authentication failed, changes outer_color and fail message color
  #       fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i> # can be set to empty
  #       fail_transition = 300 # transition time in ms between normal outer_color and fail_color
  #       capslock_color = -1
  #       numlock_color = -1
  #       bothlock_color = -1 # when both locks are active. -1 means don't change outer color (same for above)
  #       invert_numlock = false # change color if numlock is off
  #       swap_font_color = false # see below

  #       position = 0, -20
  #       halign = center
  #       valign = center
  #   }
  # '';

  #    programs.hyprlock = {
  #     enable = true;

  #     settings = {
  #       general = {
  #         hide_cursor = true;
  #         grace = 2;
  #       };

  #       background = {
  #         color = "rgba(25, 20, 20, 1.0)";
  #         path = "screenshot";
  #         blur_passes = 2;
  #         brightness = 0.5;
  #       };

  #       label = {
  #         text = "パスワードをご入力ください";
  #         color = "rgba(222, 222, 222, 1.0)";
  #         font_size = 50;
  #         font_family = "Noto Sans CJK JP";
  #         position = "0, 70";
  #         halign = "center";
  #         valign = "center";
  #       };

  #       input-field = {
  #         size = "50, 50";
  #         dots_size = 0.33;
  #         dots_spacing = 0.15;
  #         outer_color = "rgba(25, 20, 20, 0)";
  #         inner_color = "rgba(25, 20, 20, 0)";
  #         font_color = "rgba(222, 222, 222, 1.0)";
  #         placeholder_text = "パスワード";
  #       };
  #     };
  #   };
}
