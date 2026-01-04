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
      forEachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f pkgsFor.${system});
      pkgsFor = nixpkgs.lib.genAttrs (import systems) (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );
    in
    {
      devShells = forEachSystem (pkgs: {
        default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            go
            gopls
          ];

          buildInputs = with pkgs; [ ];
        };
      });
      packages = forEachSystem (pkgs: {
        default = pkgs.buildGoModule {
          pname = "template";
          version = "0.1.0";

          src = ./.;

          buildInputs = with pkgs; [ ];

          vendorHash = null;
        };
      });
    };
}
