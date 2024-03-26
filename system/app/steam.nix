{ pkgs, ... }:

{
  # OpenGL
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  programs.steam.enable = true;
  environment.systemPackages = [ pkgs.steam ];
}