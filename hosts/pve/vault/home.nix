{
  pkgs,
  lib,
  settings,
  ...
}:
{
  imports = (
    map lib.custom.relativeToHomeModules [
      "terminal/shell"
    ]
  );

  home.username = settings.username;
  home.homeDirectory = "/home/" + settings.username;
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    openssl
    git
    (pkgs.writeShellScriptBin "update-containers" ''
      	SUDO=""
      	if [[ $(id -u) -ne 0 ]]; then
      		SUDO="sudo"
      	fi

        images=$($SUDO ${pkgs.podman}/bin/podman ps -a --format="{{.Image}}" | sort -u)

        for image in $images
        do
          $SUDO ${pkgs.podman}/bin/podman pull $image
        done
    '')

  ];
}
