{
  lib,
  stdenv,
  fetchurl,
  dpkg,
  autoPatchelfHook,
  wrapGAppsHook3,
  alsa-lib,
  gtk3,
  gdk-pixbuf,
  cairo,
  glib,
  webkitgtk_4_1,
  libsoup_3,
  gst_all_1,
  libglvnd,
  libx11,
  libxtst,
  libxcomposite,
  libxrandr,
  libxext,
  libxi,
  libxfixes,
  libxdamage,
  libxcursor,
  libxrender,
  libxscrnsaver,
  libxxf86vm,
}:
stdenv.mkDerivation rec {
  pname = "buzz-desktop";
  version = "0.4.25";

  src = fetchurl {
    url = "https://github.com/block/buzz/releases/download/v${version}/Buzz_${version}_amd64.deb";
    hash = "sha256-Wy6ybnXcG+IBVOBEomj3HAzu16VgoDKnP5du1D1s/oc=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    wrapGAppsHook3
  ];

  buildInputs = [
    alsa-lib
    gtk3
    gdk-pixbuf
    cairo
    glib
    webkitgtk_4_1
    libsoup_3
    libglvnd
    libx11
    libxtst
    libxcomposite
    libxrandr
    libxext
    libxi
    libxfixes
    libxdamage
    libxcursor
    libxrender
    libxscrnsaver
    libxxf86vm
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
  ];

  dontBuild = true;
  dontConfigure = true;

  unpackPhase = ''
    dpkg-deb -x $src .
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/share

    # Copy binaries
    cp usr/bin/* $out/bin/

    # Copy desktop file and icons
    cp -r usr/share/applications $out/share/
    cp -r usr/share/icons $out/share/

    # Fix desktop file Exec path
    substituteInPlace $out/share/applications/Buzz.desktop \
      --replace-fail 'Exec=buzz-desktop' "Exec=$out/bin/buzz-desktop"

    runHook postInstall
  '';

  preFixup = ''
    # Wrap buzz-desktop with WebKit software rendering fallback
    # Hardware GL compositing fails in NixOS FHS sandbox
    gappsWrapperArgs+=(
      --set WEBKIT_DISABLE_COMPOSITING_MODE 1
    )
  '';

  meta = with lib; {
    description = "Buzz desktop app - voice AI by Block";
    homepage = "https://github.com/block/buzz";
    license = licenses.asl20;
    platforms = platforms.linux;
    mainProgram = "buzz-desktop";
  };
}
