{ pkgs, config, ... }:
{
  xdg.configFile."lf/icons".source = ./icons;
  programs.lf = {
    enable = true;
    commands =
      let
        trash = ''
          ''${{
            set -f
            gio trash "$fx"
          }}
        '';
      in
      {
        trash = trash;
        delete = trash;
        dragon-out = ''%${pkgs.dragon-drop}/bin/xdragon -a -x "$fx"'';
        editor-open = "$$EDITOR $f";
        mkdir = ''
          ''${{
            printf "Enter the name of the directory: "
            read DIR
            mkdir $DIR
          }}
        '';

      };

    settings = {
      preview = true;
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };

    keybindings = {
      c = "mkdir";
      "." = "set hidden!";

      "<enter>" = "open";
      "<delete>" = "trash";
      ee = "editor-open";

      d = "dragon-out";
    };
  };

  home.packages = with pkgs; [
    # glib
    fzf
    bat
    zip
    unzip
    gnutar
  ];

}
