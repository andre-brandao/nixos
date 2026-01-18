# nix-build -E 'with import <nixpkgs> { }; callPackage ./default.nix { }'
{
  stdenv,
  lib,
  bash,
  makeWrapper,
  gum,
  git,
}:
stdenv.mkDerivation {
  pname = "github-downloader";
  version = "08049f6";
  src = ./.;
  buildInputs = [
    bash
    git
    gum
  ];
  nativeBuildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    cp commit.sh $out/bin/commit.sh
    wrapProgram $out/bin/commit.sh \
      --prefix PATH : ${
        lib.makeBinPath [
          bash
          git
          gum
        ]
      }
  '';
}
