{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs
    nodePackages.pnpm
    nodePackages.ts-node
    typescript
    bun
    typescript
    nodePackages.typescript-language-server
    tailwindcss
    tailwindcss-language-server
    turbo
  ];
}
