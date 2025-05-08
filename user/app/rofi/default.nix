{ pkgs, config, ... }:
let
  t = name: (import ./themes/${name}.nix { inherit pkgs config; });
in
{
  xdg.configFile."rofi/config.rasi".text = t "fullscreen";
  home.packages = with pkgs; [ rofi-wayland ];

  # programs.rofi = {
  #   enable = true;
  #   package = pkgs.rofi-wayland;
  # };
}
