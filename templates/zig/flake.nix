{
  description = "Zig Template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
      ...
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
          zig
          zls
        ];

        buildInputs = with pkgs; [ ];
      in
      {
        devShells.${system}.default = pkgs.mkShell { inherit nativeBuildInputs buildInputs; };

        packages.${system}.default = pkgs.stdenv.mkDerivation {
          pname = "template";
          version = "0.0.0";
          src = ./.;

          nativeBuildInputs = nativeBuildInputs ++ [
            pkgs.zig.hook
          ];
          inherit buildInputs;
        };

      }
    );
}
