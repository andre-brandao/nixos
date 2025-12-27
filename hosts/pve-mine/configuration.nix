{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
    ../../modules/nixos/pve-vm.nix
    ../../modules/nixos/nix.nix
    # ../../modules/nixos/style.nix
    ./disko.nix
  ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  # Minecraft server settings
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers.fabric = {
      enable = true;

      # Specify the custom minecraft server package
      package = pkgs.fabricServers.fabric-1_21_11; # Specific fabric loader version

      symlinks = {
        mods = pkgs.linkFarmFromDrvs "mods" (
          builtins.attrValues {
            Fabric-API = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/gB6TkYEJ/fabric-api-0.140.2%2B1.21.11.jar";
              sha512 = "sha512-r0RleX2AQBAhpq78jFRyAOfA+MrhNCmb8/r7wxD6gfBVJGsGFPwOA3U49KhE5VqtMKv6PGdGBCKFPfxCbwhtAA==";
            };
            Lithium = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/gl30uZvp/lithium-fabric-0.21.2%2Bmc1.21.11.jar";
              sha512 = "sha512-lGJVEAE+DarxwuK22KRjyTL/YiD5G6WwzV+GhlghXwRtlNB7NGVmD1dsTcJ6WqGD373ByTA/EYlLWyWh3Gw7tg==";
            };
            # Backpacks = pkgs.fetchurl {
            #   url = "https://cdn.modrinth.com/data/MGcd6kTf/versions/Ci0F49X1/1.2.1-backpacks_mod-1.21.2-1.21.3.jar";
            #   sha512 = "6efcff5ded172d469ddf2bb16441b6c8de5337cc623b6cb579e975cf187af0b79291b91a37399a6e67da0758c0e0e2147281e7a19510f8f21fa6a9c14193a88b";
            # };
          }
        );
      };
    };
  };
}
