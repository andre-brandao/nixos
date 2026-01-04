{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/default-linux";
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
    }:
    let
      lib = nixpkgs.lib.extend (self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; });
      forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs (import systems) (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );

    in
    {
      devShells = forEachSystem (pkgs: {
        default = pkgs.mkShell rec {
          buildInputs = with pkgs; [
            git
            vim
            lsof
            # nodePackages_latest.node
            nodejs_latest
            bun
            python3
            claude-code
            opencode
            playwright-driver.browsers
          ];
          nativeBuildInputs = with pkgs; [
            gtk4
            gtk4-layer-shell
            webkitgtk_6_0
            libadwaita
            glib
            cairo
            gdk-pixbuf
            pango
            libsoup_3
            glib-networking
            at-spi2-atk
            at-spi2-core
            dbus
            cups
            xorg.libX11
            xorg.libXcomposite
            xorg.libXdamage
            xorg.libXext
            xorg.libXfixes
            xorg.libXrandr
            libdrm
            mesa
            expat
            libxkbcommon
            harfbuzz
            freetype
            vulkan-loader
            graphene
            stdenv.cc.cc.lib
          ];
          shellHook = ''
            export GIO_MODULE_DIR="${pkgs.glib-networking}/lib/gio/modules"
            export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath nativeBuildInputs}:$LD_LIBRARY_PATH"

          '';
        };
      });

    };
}
