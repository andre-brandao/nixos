{ pkgs, lib, ... }:

{
  # home.packages = with pkgs; [ kitty ];
  programs.kitty = lib.mkForce {
    enable = true;
    settings = {
      background_opacity = "0.8";

      background_blur = 5;
      dynamic_background_opacity = true;

      modify_font = "cell_width 90%";
      copy_on_select = "clipboard";
      window_padding_width = 2;

      confirm_os_window_close = 0;
    };
  };

}
