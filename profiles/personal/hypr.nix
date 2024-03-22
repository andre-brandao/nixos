# home.nix

{ pkgs, lib, config, ... }:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${(pkgs.waybar.override {
    wireplumberSupport = false;
    })}/bin/waybar &

    ${pkgs.swww}/bin/swww init &
  
    ${pkgs.dunst}/bin/dunst &

    # ${pkgs.swww}/bin/swww img ${./wallpaper.png} &
      
  '';
in
{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      exec-once = ''${startupScript}/bin/start'';
    };
  };
}
