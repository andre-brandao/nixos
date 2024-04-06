{ pkgs, ... }:

{
  # OpenGL
  environment.systemPackages = with pkgs; [ minecraft jdk ];
}
