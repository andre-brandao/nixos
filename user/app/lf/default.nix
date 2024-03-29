{ pkgs, config, ... }: {
  programs.lf = {
    enable = true;
    commands = {
      dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
      editor-open = ''$$EDITOR $f'';
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
      ee = "editor-open";

      do = "dragon-out";
    };


  };
}
