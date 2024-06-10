{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs
    nodePackages.pnpm
    nodePackages.ts-node
    typescript
  ];
}
