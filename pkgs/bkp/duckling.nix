{
  stdenv,
  lib,
  dpkg,
  fetchurl,
  autoPatchelfHook,
  glib-networking,
  openssl,
  webkitgtk,
  wrapGAppsHook,
}:

stdenv.mkDerivation rec {
  name = "duckling";
  version = "";
  src = fetchurl {
    url = "https://github.com/I1xnan/duckling/releases/${version}";
  };
}
