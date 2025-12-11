{ inputs, ... }:
let
  additions = final: prev: {
    hyprland-preview-share-picker = final.callPackage ../pkgs/hyprland-preview-share-picker { };

  };

  overlay-unstable = final: prev: rec {
    # unstable = inputs.nixpkgs-unstable.legacyPackages.${prev.stdenv.hostPlatform.system};
    # use this variant if unfree packages are needed:
    unstable = import inputs.nixpkgs-unstable {
      system = prev.stdenv.hostPlatform.system;
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

    hyprland = unstable.hyprland;
    xdg-desktop-portal-hyprland = unstable.xdg-desktop-portal-hyprland;
  };
in
{

  default = final: prev: (additions final prev) // (overlay-unstable final prev);

}
