{ lib, ... }:
rec {
  # use path relative to the root of the project
  relativeToRoot = lib.path.append ../.;

  relativeToHomeModules = lib.path.append ../modules/home-manager;

  relativeToNixOSModules = lib.path.append ../modules/nixos;

  pveNixVM =
    {
      host,
      specialArgs,
      extraModules,
    }:
    lib.nixosSystem {
      modules = [
        ../hosts/pve/${host}/configuration.nix
        { nixpkgs.hostPlatform = "x86_64-linux"; }
      ]
      ++ extraModules;
      inherit specialArgs;
    };

  # Scans ../hosts/pve/ folder and creates an dict of nixosSystems for each host (pve-*) using the above function to create each system
  scanPveHosts =
    {
      specialArgs,
      extraModules,
    }:
    lib.pipe (builtins.readDir ../hosts/pve) [
      (lib.attrsets.filterAttrs (_path: type: type == "directory"))
      (lib.mapAttrsToList (key: value: key))
      (builtins.map (host: {
        name = "pve-${host}";
        value = pveNixVM {
          inherit host specialArgs extraModules;
        };
      }))
      builtins.listToAttrs
    ];

  # Imports any .nix file in the specific directory, and any folder. Note this
  # means that a folder containing `default.nix` and other *.nix files is expected
  # to use the other *.nix files in that folder as supplementary, and not distinct
  # modules
  scanPaths =
    path:
    builtins.map (f: (path + "/${f}")) (
      builtins.attrNames (
        lib.attrsets.filterAttrs (
          path: _type:
          (_type == "directory") # include directories
          || (
            (path != "default.nix") # ignore default.nix
            && (lib.strings.hasSuffix ".nix" path) # include .nix files
          )
        ) (builtins.readDir path)
      )
    );

  leaf = str: lib.last (lib.splitString "/" str);

  scanPathsFilterPlatform =
    path:
    lib.filter (
      path: builtins.match "nixos.nix|darwin.nix|nixos|darwin" (leaf (builtins.toString path)) == null
    ) (scanPaths path);
}
