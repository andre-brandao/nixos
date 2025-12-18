{ pkgs, ... }:
{
  home.packages = with pkgs; [ unstable.ashell ];
}
