{
  lib,
  stdenv,
  fetchurl,
  dpkg,
  autoPatchelfHook,
  wrapGAppsHook3,
  bash,
  coreutils,
  findutils,
  git,
  gnugrep,
  gnused,
  alsa-lib,
  gtk3,
  gdk-pixbuf,
  cairo,
  glib,
  glib-networking,
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
  version = "0.4.26";

  src = fetchurl {
    url = "https://github.com/block/buzz/releases/download/v${version}/Buzz_${version}_amd64.deb";
    hash = "sha256-G1IHVuz8KK2BmBos1cxmiPeF9Eez9djVU1RJBvWb9SE=";
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
    # GIO TLS backend (libgiognutls). Without it WebKit's fetch() fails every
    # https:// request with "Load failed" — the WebSocket still works because
    # Tauri routes it through Rust, not the webview.
    glib-networking
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
    #
    # BUZZ_SHELL / PATH: managed agents shell out via buzz-dev-mcp, which spawns
    # bare `bash` off the PATH it inherits from this process. Buzz normally
    # widens that PATH by probing a login shell, but login_shell_candidates()
    # hardcodes /bin/zsh and /bin/bash (discovery.rs:779) — neither exists on
    # NixOS, so the probe fails and the agent is left with the launcher's PATH.
    # Pin a real bash and append the tools agents actually invoke.
    gappsWrapperArgs+=(
      --set WEBKIT_DISABLE_COMPOSITING_MODE 1
      --set-default BUZZ_SHELL ${bash}/bin/bash
      --suffix PATH : ${
        lib.makeBinPath [
          bash
          coreutils
          findutils
          git
          gnugrep
          gnused
        ]
      }
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
