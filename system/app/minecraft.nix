{ pkgs, ... }:

{
  # OpenGL
  environment.systemPackages = with pkgs; [ jdk prismlauncher ];
}
