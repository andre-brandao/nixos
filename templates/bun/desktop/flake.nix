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
      forAllSystems = f: nixpkgs.lib.foldl' nixpkgs.lib.recursiveUpdate { } (map f (import systems));
    in
    forAllSystems (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
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
        ];
      in
      {

        devShells.${system}.default = pkgs.mkShell {
          inherit nativeBuildInputs buildInputs;
          shellHook = ''
            export GIO_MODULE_DIR="${pkgs.glib-networking}/lib/gio/modules"
            export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath nativeBuildInputs}:$LD_LIBRARY_PATH"
          '';
        };

      }
    );
}
