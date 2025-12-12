{ pkgs, inputs, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  # sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/andre/.config/sops/age/keys.txt";
}
