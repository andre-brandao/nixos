{ pkgs, ... }:
{
  programs.helix = {
    languages = {
      language-server = {
        astro-ls = {
          command = "${pkgs.nodePackages."@astrojs/language-server"}/bin/astro-ls";
          args = [ "--stdio" ];
        };
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
          language-servers = [ "nixd" ];
        }
        # {
        #   name = "python";
        #   auto-format = true;
        # }
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
          formatter = {
            command = "goimports";
          };
        }
      ];
    };
    # ***** LSP packages *****
    extraPackages =
      with pkgs;
      with nodePackages;
      [
        bash-language-server # BASH
        # lldb # debugger
        marksman # Markdown

        elixir-ls # Elixir

        # # NIX
        # nixpkgs-fmt:
        nil
        # GO
        gopls
        gotools

        # clang-tools     # C/C++
        lua-language-server
        # RUST
        # rust-analyzer

        # PYTHON
        # pyright
        # (python3.withPackages (
        #   ps: with ps; [ python-lsp-server ] ++ python-lsp-server.optional-dependencies.all
        # ))

        # JAVASCRIPT AND CIA
        typescript
        # vscode-langservers-extracted
        typescript-language-server
        svelte-language-server
        yaml-language-server
        # stylelint

        # nodePackages."@astrojs/language-server"

        # dockerfile-language-server-nodejs
      ];
  };
}
