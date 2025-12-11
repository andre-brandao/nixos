{ appimageTools, fetchurl, ... }:

appimageTools.wrapType2 rec {
  pname = "duckling";
  version = "v0.0.46";
  src = fetchurl {
    url = "https://github.com/I1xnan/duckling/releases/download/${version}/Duckling_0.0.46";
    sha256 = "sha256-hZiJ8JLzLhtD1W8DAso3yBAJYhFE+nJEbQJa59AWjnU=";
  };

  extraInstallCommands =
    let
      appimageContents = appimageTools.extract {
        inherit pname version src;
      };
    in
    ''
      # Install .desktop file
      install -m 444 -D ${appimageContents}/zen.desktop $out/share/applications/${pname}.desktop
      # Install icon
      install -m 444 -D ${appimageContents}/zen.png $out/share/icons/hicolor/128x128/apps/${pname}.png
    '';

  meta = {
    platforms = [ "x86_64-linux" ];
  };
}
