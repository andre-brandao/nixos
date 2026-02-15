{ inputs, settings, ... }:
let
  additions = final: prev: {
    hyprland-preview-share-picker = final.callPackage ../pkgs/hyprland-preview-share-picker { };
    niri-scratchpad = final.callPackage ../pkgs/niri-scratchpad { };

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
          pkg: builtins.elem (inputs.nixpkgs.lib.getName pkg) settings.allowUnfree;
      };

      stable = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = false;
        config.allowUnfreePredicate =
          pkg: builtins.elem (inputs.nixpkgs.lib.getName pkg) settings.allowUnfree;
      };

      # from unstable
      hyprland = unstable.hyprland;
      xdg-desktop-portal-hyprland = unstable.xdg-desktop-portal-hyprland;
      # from inputs
      # devenv = inputs.devenv.packages.${system}.default;
      devenv = unstable.devenv;
      # dagger = inputs.dagger.packages.${system}.dagger;
      # walker = inputs.walker.packages.${system}.walker;
      gpuishell = inputs.shell.packages.${system}.default;
      # calelestia = inputs.caelestia.packages.${system}.default;
      # elephant =
      # zen-browser = inputs.zen-browser.packages.${system}.twilight;
    };

in
{

  default = final: prev: (additions final prev) // (overlay-unstable final prev);

}
