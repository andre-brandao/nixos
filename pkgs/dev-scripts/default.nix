# nix-build -E 'with import <nixpkgs> { }; callPackage ./default.nix { }'
{
  stdenv,
  lib,
  bash,
  makeWrapper,
  gum,
  git,
  jq,
}:
let
  basePkgs = [
    bash
    git
    gum
  ];

  mkDevScript =
    {
      name,
      pkgs ? [ ],
    }:
    ''
      cp ${name}.sh $out/bin/${name}
      wrapProgram $out/bin/${name} --prefix PATH : ${lib.makeBinPath (basePkgs ++ pkgs)}
    '';
in
stdenv.mkDerivation {
  pname = "dev-scripts";
  version = "4.2.0";
  src = ./.;
  buildInputs = basePkgs;
  nativeBuildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    ${mkDevScript { name = "commit"; }}
    ${mkDevScript {
      name = "templates";
      pkgs = [ jq ];
    }}
    ${mkDevScript { name = "branches"; }}
    ${mkDevScript { name = "stage"; }}
  '';
}
