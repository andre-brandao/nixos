{
  lib,
  appimageTools,
  fetchurl,
}:
let
  pname = "buzz";
  version = "0.4.26";

  src = fetchurl {
    url = "https://github.com/block/buzz/releases/download/v${version}/Buzz_${version}_amd64.AppImage";
    hash = "sha256-XOelbuUdtmw9IZ9Plb2SAh/GiVY+pqQlRBdR9oWCgg8=";
  };

  appimageContents = appimageTools.extract { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  # Linked by the bundled binaries but absent from both the AppImage and the
  # default appimageTools FHS environment.
  extraPkgs =
    pkgs: with pkgs; [
      zstd # libzstd.so.1
      elfutils # libelf.so.1
      libffi # libffi.so.8
    ];

  extraInstallCommands = ''
    install -Dm444 ${appimageContents}/Buzz.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/Buzz.desktop \
      --replace-fail 'Exec=buzz-desktop' 'Exec=${pname}' \
      --replace-fail 'Categories=' 'Categories=AudioVideo;Utility;'
    cp -r ${appimageContents}/usr/share/icons $out/share/
  '';

  meta = {
    description = "Hive mind communication platform";
    homepage = "https://github.com/block/buzz";
    downloadPage = "https://github.com/block/buzz/releases";
    license = lib.licenses.asl20;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    mainProgram = pname;
  };
}
