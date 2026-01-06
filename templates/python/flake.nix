{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    poetry2nix.url = "github:nix-community/poetry2nix";
    systems.url = "github:nix-systems/default";

  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
      poetry2nix,
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
        inherit (poetry2nix.lib.mkPoetry2Nix { inherit pkgs; }) mkPoetryApplication;
      in
      {

        packages.${system}.default = mkPoetryApplication { projectDir = self; };

        devShells.${system}.default = pkgs.mkShellNoCC {
          packages = with pkgs; [
            (mkPoetryApplication { projectDir = self; })
            poetry
          ];
        };

      }
    );
}
