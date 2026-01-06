{
  description = "Go Template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    {
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
          go
          gopls
        ];
        buildInputs = with pkgs; [ ];
      in

      {
        packages.${system}.default = pkgs.buildGoModule {
          pname = "template";
          version = "0.1.0";

          src = ./.;

          inherit buildInputs;

          vendorHash = null;

        };

        devShells.${system}.default = pkgs.mkShell { inherit nativeBuildInputs buildInputs; };
      }
    );
}
