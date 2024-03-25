{ ... }: {
  imports = [
    ./bootloader.nix
    ./firewall.nix
    ./networking.nix
    ./language.nix
    ./sound.nix
    ./printer.nix
    ./gc.nix

    # ./fingerprint-scanner.nix
  ];
}
