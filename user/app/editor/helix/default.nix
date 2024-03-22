{ config, pkgs, inputs, ... }: {
  home.packages = with pkgs; [


    helix

    # Language servers
    typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server # YAML / JSON
    nodePackages.vls
    nodePackages."@astrojs/language-server" # Astro
    nodePackages.svelte-language-server

    nodePackages.bash-language-server # Bash
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.pyright # Python
    nodePackages.stylelint

    lldb # debugger

    elixir_ls # Elixir
    marksman # Markdown
    (python3.withPackages (ps:
      with ps;
      [ python-lsp-server ] ++ python-lsp-server.optional-dependencies.all))
  ];
  programs.helix = {
    enable = true;
    themes = {
      transparentize = {
        # THEME TO BE USED WITHOU BG
        "inherits" = "adwaita-dark"; # jellybeans tokyonight
        "ui.background" = { };
      };
    };
    settings = {
      theme = "transparentize";
      editor = {
        scrolloff = 8;

        line-number = "relative";
        auto-format = true;
        auto-completion = true;
        idle-timeout = 200;

        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        # rainbow-brackets = true;

        statusline = {
          # mode-separator = "";
          separator = "";
          # mode-separator = "";
          # separator = "";
          # separator = "";
          left = [
            "mode"
            "spinner"

          ];
          center = [
            "version-control"
            "spacer"
            "separator"
            "file-name"
            "read-only-indicator"
            "file-modification-indicator"
          ];
          right = [
            "diagnostics"
            # "file-encoding"
            # "file-line-ending"
            "selections"
            "register"
            "file-type"
            # "separator"
            "position-percentage"
            "position"
          ];
          mode = {
            normal = "NOR   ";
            insert = "   INS";
            select = "SELECT";
          };
        };

        whitespace = {
          render = "all";
          characters = {
            space = "·";
            nbsp = "⍽";
            tab = "→";
            newline = "⤶";
          };
        };
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
      keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
        esc = [ "collapse_selection" "keep_primary_selection" ];
      };
    };
    languages = {
      language-server = {
        astro-ls = {
          command =
            "${pkgs.nodePackages."@astrojs/language-server"}/bin/astro-ls";
          args = [ "--stdio" ];
        };
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
        }
        {
          name = "python";
          auto-format = true;
        }
        {
          name = "javascript";
          auto-format = true;
        }
        {
          name = "typescript";
          auto-format = true;
        }
        {
          name = "json";
          auto-format = true;
        }
        {
          name = "yaml";
          auto-format = true;
        }
        {
          name = "html";
          auto-format = true;
        }
        {
          name = "css";
          auto-format = true;
        }
        {
          name = "astro";
          auto-format = true;
          language-servers = [ "astro-ls" ];
        }
        {
          name = "svelte";
          auto-format = true;
          language-servers = [ "svelteserver" ];
        }
        {
          name = "elixir";
          auto-format = true;
          language-servers = [ "elixir-ls" ];
        }
        {
          name = "markdown";
          auto-format = true;
          language-servers = [ "marksman" ];
        }
        {
          name = "go";
          auto-format = true;
          formatter = { command = "goimports"; };
        }
      ];
    };
  };
}
