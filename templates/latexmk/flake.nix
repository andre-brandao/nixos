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
      packages = forEachSystem (pkgs: {
        default = pkgs.callPackage ./default.nix { };
      });
    };
}
