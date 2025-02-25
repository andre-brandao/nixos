{ appimageTools, fetchurl, ... }:
let
  pname = "zen-browser";
  version = "1.8.1b";

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/latest/download/zen-x86_64.AppImage";
    sha256 = "sha256-1s5T9adpo55cLk+ECaiYtZCEQtuAkmr7/4IuxRfsL4U=";
  };

in
appimageTools.wrapType2 {
  inherit pname version src;
}
