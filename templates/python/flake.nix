{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    poetry2nix = {
      url = "github:nix-community/poetry2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
        myPythonApp = mkPoetryApplication {
          projectDir = ./.;
          meta = {
            mainProgram = "sample_package";
          };
        };
      in
      {

        packages.${system} = {
          default = myPythonApp;
          docker-image = pkgs.dockerTools.buildImage {
            name = "my-python-app";
            # tag = "latest";
            config = {
              Cmd = [ "${nixpkgs.lib.getExe myPythonApp}" ];
            };
          };
        };

        devShells.${system}.default = pkgs.mkShellNoCC {
          packages = with pkgs; [
            myPythonApp
            poetry
          ];
        };

        apps.${system}.default = {
          type = "app";
          program = "${nixpkgs.lib.getExe myPythonApp}";
        };

      }
    );
}
