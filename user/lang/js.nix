{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs
    nodePackages.pnpm
  ];
}
