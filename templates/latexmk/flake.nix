{
  description = "A simple LaTeX template for writing documents with latexmk";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
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
          config.allowUnfree = true;
        };
      in

      {
        packages.${system}.default = pkgs.callPackage ./default.nix { };
      }
    );
}
