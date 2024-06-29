{pkgs, ... }:
let
inherit (pkgs) libnotify papirus-icon-theme;
in
{
home.packages = [ libnotify ];

  services.dunst = {
    enable = true;

    iconTheme = {
      package = papirus-icon-theme;
      name = "Papirus";
    };

    settings = {
      global = {
        width = 400;
        # height = 300;
        offset = "30x50";
        transparency = 10;
        origin = "top-right";
        # origin = "bottom-right";
        # frame_color = "#${config.lib.stylix.colors.base0A}";
        frame_width = 1;
        format = "<b>%s</b>\\n%b";
        padding = 6;
        horizontal_padding = 6;
        icon_position = "left";

        corner_radius = 5;
        icon_corner_radius = 3;

        # progress_bar = true;

        # separator_height = 5;

        word_wrap = "yes";
        gap_size = 5;

        idle_threshold = 120;
                markup = "full";
        min_icon_size = 32;
        max_icon_size = 128;

      };
    };
  };
}
