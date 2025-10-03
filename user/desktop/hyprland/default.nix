# home.nix

{
  inputs,
  pkgs,
  pkgs-unstable,
  config,
  lib,
  userSettings,
  ...
}:
{
  imports = [
    ./start.nix
    ./keybinds.nix
    ./scratchpad.nix
    ./rules.nix
    ./monitor.nix
    ./plugins.nix
    ./lockscreen.nix
    # ./notification.nix
    ./deps.nix
    ./gestures.nix
    # ./bar/waybar.nix
    ./defaults/animations.nix
    ./defaults/keybinds.nix
  ];

  xdg.desktopEntries."org.gnome.Settings" = {
    name = "Settings";
    comment = "Gnome Control Center";
    icon = "org.gnome.Settings";
    exec = "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome-control-center}/bin/gnome-control-center";
    categories = [ "X-Preferences" ];
    terminal = false;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland;

    systemd.enable = false;
    xwayland.enable = true;

    settings = {

      xwayland = {
        force_zero_scaling = true;
      };
      env = [
        "GDK_SCALE,1"
        "QT_QPA_PLATFORM,wayland"
      ];

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input = {
        kb_layout = "us,br";
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:win_space_toggle,caps:escape";
        kb_rules = "";

        follow_mouse = 1; # Cursor movement will always change focus to the window under the cursor.

        focus_on_close = 1;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
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

        "col.inactive_border" = "0x33${config.lib.stylix.colors.base03}";
        "col.active_border" =
          ''0xff${config.lib.stylix.colors.base0B} 0xff${config.lib.stylix.colors.base0C} 45deg'';

        # layout = "dwindle";
        layout = "master";

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;
        snap = {
          enabled = true;
        };
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 6;
        # border_part_of_window = false;
        # blur.enabled = false; # disabled for battery life
        # shadow.enabled = false;
        # "col.shadow" = "rgba(1a1a1aee)";
        #
        blur = {
          enabled = true;
          brightness = 1.0;
          contrast = 1.0;
          noise = 0.01;

          vibrancy = 0.2;
          vibrancy_darkness = 0.5;

          passes = 4;
          size = 7;

          popups = true;
          popups_ignorealpha = 0.2;
        };

        shadow = {
          enabled = false;
          color = "rgba(00000055)";
          ignore_window = true;
          offset = "0 15";
          range = 100;
          render_power = 2;
          scale = 0.97;
        };
        inactive_opacity = 0.90;
      };

      master = {
        #  # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        # new_is_master = true;
        # no_gaps_when_only = 1;
      };
      dwindle = {
        #   # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = "yes";
        preserve_split = "yes";
        # no_gaps_when_only = 2;
      };

      group = {
        auto_group = true;
        insert_after_current = true;
        drag_into_group = 2;
        merge_floated_into_tiled_on_groupbar = true;
        # BORDERS
        "col.border_inactive" = "0x33${config.lib.stylix.colors.base03}";
        "col.border_active" =
          ''0xff${config.lib.stylix.colors.base0B} 0xff${config.lib.stylix.colors.base0C} 45deg'';

        groupbar = {
          enabled = true;
          gradients = true;
          # font_size = 12;
          # font_size = 0;
          render_titles = false;
          # font_weight_active = "bold";
          # indicator_gap = -5;
          # gaps_out = 0;
          indicator_height = 0;
          height = 5;
          rounding = 3;
          text_color = "0xff${config.lib.stylix.colors.base00}";
          # text_color_inactive = "0xff${config.lib.stylix.colors.base05}";
          "col.active" = "0xff${config.lib.stylix.colors.base0D}";
          # "col.active" = "0xff${config.lib.stylix.colors.base02}";
          "col.inactive" = "0xff${config.lib.stylix.colors.base03}";
          keep_upper_gap = false;
        };
      };

      misc = {
        #  # See https://wiki.hyprland.org/Configuring/Variables/ for more
        force_default_wallpaper = 0;
        focus_on_activate = true;
        animate_mouse_windowdragging = false;

        # vfr = true;
      };
      debug = {
        disable_logs = false;

      };

      "$scratchpadsize" = "size 80% 85%";
      "$scratchpad" = "class:^(scratchpad)$";
      windowrulev2 = [
        "float,$scratchpad"
        "$scratchpadsize,$scratchpad"
        "workspace special silent,$scratchpad"
        "center,$scratchpad"
      ];

      binds = {
        allow_workspace_cycles = true;
        movefocus_cycles_groupfirst = true;
      };

    };
  };

  # home.file.".config/hypr/hyprpaper.conf".text = ''
  #   preload = ${config.stylix.image}

  #   wallpaper = eDP-1,${config.stylix.image}

  #   wallpaper = HDMI-A-1,${config.stylix.image}

  #   wallpaper = DP-1,${config.stylix.image}
  #   wallpaper = DP-2,${config.stylix.image}
  #   wallpaper = DP-3,${config.stylix.image}

  # '';

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
