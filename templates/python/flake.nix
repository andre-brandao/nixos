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

      forAllSystems = pkgs: nixpkgs.lib.genAttrs (import systems);
      pkgs = forAllSystems (system: nixpkgs.legacyPackages.${system});
      # pkgs = forAllSystems (system: nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (
        system:
        let
          inherit (poetry2nix.lib.mkPoetry2Nix { pkgs = pkgs.${system}; }) mkPoetryApplication;
        in
        {
          default = mkPoetryApplication { projectDir = self; };
        }
      );

      devShells = forAllSystems (
        system:
        let
          inherit (poetry2nix.lib.mkPoetry2Nix { pkgs = pkgs.${system}; }) mkPoetryEnv;
        in
        {
          default = pkgs.${system}.mkShellNoCC {
            packages = with pkgs.${system}; [
              (mkPoetryEnv { projectDir = self; })
              poetry
            ];
          };
        }
      );
    };
}
