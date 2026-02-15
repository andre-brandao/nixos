{ lib, python3Packages }:

let
  binname = "nscratch";
in
python3Packages.buildPythonApplication {
  pname = "niri-scratchpad";
  version = "0.0.2";
  pyproject = false;
  propagatedBuildInputs = [ ];
  dontUnpack = true;
  installPhase = "install -Dm755 ${./ns.py} $out/bin/${binname}";

  meta = {
    description = "Scratchpad support for the Niri Wayland compositor";
    homepage = "https://github.com/gvolpe/niri-scratchpad";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ gvolpe ];
    mainProgram = binname;
    platforms = lib.platforms.linux;
  };
}
