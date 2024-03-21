{ pkgs, ... }: {
  imports = [
    ./bootloader.nix
    ./firewall.nix
    ./networking.nix
    ./language.nix
    ./sound.nix
    ./printer.nix
    ./gc.nix
  ];

  environment.systemPackages = with pkgs; [ nixos-conf-editor ];
}
