{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
let
  nix-minecraft = import (
    builtins.fetchTarball {
      url = "https://github.com/Infinidoge/nix-minecraft/archive/master.tar.gz";
      sha256 = "sha256:16ggcvd78am3y8xnx9d0ns17zrqx0qj6abh8ffhd379ykwa77i2n";
    }
  );
in
{
  imports = [
    nix-minecraft.nixosModules.minecraft-servers
  ];

  nixpkgs.overlays = [ nix-minecraft.overlay ];

  # Minecraft server settings
  services.minecraft-servers = {
    enable = true;
    eula = true;
    managementSystem = {
      tmux.enable = true;
      # systemd-socket.enable = true;
    };
    dataDir = "/srv/minecraft";
    openFirewall = true;
    servers = {
      fabric-moded-1_21_11 = {
        enable = true;

        # Specify the custom minecraft server package
        package = pkgs.fabricServers.fabric-1_21_11; # Specific fabric loader version
        operators = {
          "Andre_Brandao" = {
            uuid = "73a7cbb8-906c-4833-9abc-d4f5d50196ce";
            bypassesPlayerLimit = true;
            level = 3;
          };

        };
        serverProperties = {
          server-port = 25565;
          difficulty = 3;
          gamemode = 0;
          max-players = 10;
          motd = "Turtle mine server!";
          # white-list = true;
          # allow-cheats = false;
          spawn-protection = 1;
          enable-rcon = true;
          "rcon.password" = "turtle";
          simulation-distance = 5;
          view-distance = 10;

        };
        jvmOpts =
          # "-Xms${memory}"
          # "-Xmx${memory}"
          "-Xms12G -Xmx12G";
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
              BlueMap = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/swbUV1cr/versions/gpuTeXXq/bluemap-5.15-fabric.jar";
                sha512 = "sha512-PKFnu77123wZE0S7LSJgw221AhU2aZxvSj2HrHaUwEBy7VCnMVYiMl8j0YaTGXi2s0/j2sQCZF3aSf8yTxEwPg==";
              };
              # TownsAndTowers = pkgs.fetchurl {
              #   url = "https://cdn.modrinth.com/data/DjLobEOy/versions/vXLcy6ev/t_and_t-fabric-neoforge-1.13.8.jar";
              #   sha512 = "sha512-Kue9/qBuJ6Tp2W+7/WQnHEaECsBMzfTE5EBxM8Lj5cIPa1b8yuh6/itbxMnjeiGd4Fyjf9hZYmltsY0YJV5LDA==";
              # };
              # Tectonic = pkgs.fetchurl {
              #   url = "https://cdn.modrinth.com/data/lWDHr9jE/versions/7olSYFxL/tectonic-3.0.19-fabric-1.21.11.jar";
              #   sha512 = "sha512-zgZD1Fqse14/OjL8AZKDcdl2Eqncbo33Ib8hW/kK+gIbjo1+GcDQAGDDyYWRrskNLqUfWU/cABIFHyBlf66F7w==";
              # };
              # JourneyMap = pkgs.fetchurl {
              #   url = "https://cdn.modrinth.com/data/lfHFW1mp/versions/t3uYUEB5/journeymap-fabric-1.21.11-6.0.0-beta.53.jar";
              #   sha512 = lib.fakeSha512;
              # };
              # Backpacks = pkgs.fetchurl {
              #   url = "https://cdn.modrinth.com/data/MGcd6kTf/versions/Ci0F49X1/1.2.1-backpacks_mod-1.21.2-1.21.3.jar";
              #   sha512 = "6efcff5ded172d469ddf2bb16441b6c8de5337cc623b6cb579e975cf187af0b79291b91a37399a6e67da0758c0e0e2147281e7a19510f8f21fa6a9c14193a88b";
              # };
            }
          );
        };
      };
    };
  };

}
