{ pkgs, userSettings }:
let
  # TODO: need some kde components
  backgroundUrl = builtins.readFile ../themes/${userSettings.theme}/backgroundurl.txt;
  backgroundSha256 = builtins.readFile ../themes/${userSettings.theme}/backgroundsha256.txt

  ;

  image = pkgs.fetchurl {
    url = backgroundUrl;
    sha256 = backgroundSha256;
  };
in
pkgs.stdenv.mkDerivation {
  name = "chili-sddm-theme";

  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "kde-plasma-chili";
    rev = "a371123959676f608f01421398f7400a2f01ae06";
    sha256 = "17pkxpk4lfgm14yfwg6rw6zrkdpxilzv90s48s2hsicgl3vmyr3x";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
    rm $out/components/artwork/background.jpg
    cp -r ${image} $out/components/artwork/background.jpg
  '';
  # installPhase = ''
  #   mkdir -p $out
  #   cp -R ./* $out/
  #   cd $out/
  #   rm Background.jpg
  #   cp -r ${image} $out/Background.jpg
  # '';
}
