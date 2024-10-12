{ pkgs-unstable, ... }:
{
  home.packages = with pkgs-unstable; [
    nodejs
    nodePackages.pnpm
    nodePackages.ts-node
    typescript
    # bun
    typescript
    nodePackages.typescript-language-server
    tailwindcss
    tailwindcss-language-server
    turbo
  ];
}
