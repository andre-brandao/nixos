{ pkgs, ... }:

{
  home.file.".config/qtile/config.py".source = ./config.py;
}
