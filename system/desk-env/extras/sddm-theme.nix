{ pkgs, userSettings }:
let

  backgroundUrl = builtins.readFile (
    ./. + "../../../themes" + ("/" + userSettings.theme) + "/backgroundurl.txt"
  );
  backgroundSha256 = builtins.readFile (
    ./. + "../../../themes/" + ("/" + userSettings.theme) + "/backgroundsha256.txt"
  );
  image = pkgs.fetchurl {
    url = backgroundUrl;
    sha256 = backgroundSha256;
  };
in
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-suggar-dark";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
    cd $out/

    rm Background.png
    cp -f ${image} $out/Background.png
  '';
}
