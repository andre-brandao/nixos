{ ... }:
{
  imports = [
    ./bootloader.nix
    ./networking.nix
    ./language.nix
    ./sound.nix
    # ./printer.nix
    ./gc.nix

    ./bluetooth.nix
    # ./fingerprint-scanner.nix
  ];
}
