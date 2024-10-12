{ inputs,pkgs-unstable, ... }: { 
    nixpkgs.overlays = [(
        final: prev: {
        hyprland = let
            libinput = prev.libinput.overrideAttrs (self: {
                name = "libinput";
                version = "1.26.1";
                src = final.fetchFromGitLab {
                    domain = "gitlab.freedesktop.org";
                    owner = "libinput";
                    repo = "libinput";
                    rev = self.version;
                    hash = "sha256-3iWKqg9HSicocDAyp1Lk87nBbj+Slg1/e1VKEOIQkyQ=";
                };
            });
        in
            inputs.hyprland.packages.${prev.system}.hyprland.override {
                libinput = libinput;
                aquamarine = inputs.aquamarine.packages.${prev.system}.aquamarine.override {
                    libinput = libinput;
                };
                wayland-scanner = pkgs-unstable.wayland-scanner;

            };
        }
    )];
}