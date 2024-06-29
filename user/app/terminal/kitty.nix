{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [ kitty ];
  programs.kitty.enable = true;
  programs.kitty.settings = {
    background_opacity = lib.mkForce "0.8";
    copy_on_select = "clipboard";
    window_padding_width = 2;
  };
}
