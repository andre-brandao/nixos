{ ... }:
{

  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 400;
        # height = 300;
        # offset = "30x50";
        transparency = 10;
        origin = "top-center";
        # origin = "bottom-right";
        # frame_color = "#${config.lib.stylix.colors.base0A}";
        frame_width = 1;
        format = "<b>%s</b>\\n%b";
        padding = 6;
        horizontal_padding = 6;
        max_icon_size = 80;
        icon_position = "left";

        corner_radius = 5;
        icon_corner_radius = 3;

        # progress_bar = true;

        # separator_height = 5;

        gap_size = 5;
      };
    };
  };
}
