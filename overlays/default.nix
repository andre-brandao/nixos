{ inputs, ... }:
let
  additions = final: prev: {
    hyprland-preview-share-picker = final.callPackage ../pkgs/hyprland-preview-share-picker { };

  };

  overlay-unstable =
    final: prev:
    let
      system = prev.stdenv.hostPlatform.system;
    in
    rec {
      # unstable = inputs.nixpkgs-unstable.legacyPackages.${prev.stdenv.hostPlatform.system};
      # use this variant if unfree packages are needed:
      unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = false;
        config.allowUnfreePredicate =
          pkg:
          builtins.elem (inputs.nixpkgs.lib.getName pkg) [
            "spotify"
            "steam-unwrapped"
            "steam"
            "discord"
            "obsidian"
          ];
      };

      stable = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = false;
      };

      # from unstable
      hyprland = unstable.hyprland;
      xdg-desktop-portal-hyprland = unstable.xdg-desktop-portal-hyprland;
      # from inputs
      devenv = inputs.devenv.packages.${system}.default;
      dagger = inputs.dagger.packages.${system}.dagger;
      walker = inputs.walker.packages.${system}.walker;
      # elephant =
      # zen-browser = inputs.zen-browser.packages.${system}.twilight;
    };

in
{

  default = final: prev: (additions final prev) // (overlay-unstable final prev);

}
