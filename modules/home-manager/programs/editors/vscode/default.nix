{
  config,
  pkgs,
  inputs,
  settings,
  ...
}:
let
  prettier = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
in
{

  programs.vscode = {
    enable = true;
    # open source version of vscode
    package = pkgs.vscodium.fhs;
    profiles.default.userSettings = {
      "java.jdt.ls.java.home" = "${pkgs.jdk17}";
      "files.autoSave" = "afterDelay";

      "telemetry.telemetryLevel" = "off";

      "window.titleBarStyle" = "custom";

      "workbench.sideBar.location" = "right";
      "workbench.tree.renderIndentGuides" = "always";
      "workbench.tree.indent" = 12;

      "workbench.iconTheme" = "material-icon-theme";
      "workbench.editor.labelFormat" = "short";
      # Behaviour
      "editor.renderWhitespace" = "boundary";
      "editor.suggest.preview" = true;
      "editor.formatOnSave" = true;
      "editor.formatOnPaste" = true;
      "editor.linkedEditing" = true;
      "editor.lineNumbers" = "relative";
      "editor.renderLineHighlight" = "all";
      "editor.tabSize" = 2;

      "github.copilot.enable" = {
        "*" = true;
        "plaintext" = true;
        "markdown" = true;
        "scminput" = false;
      };
      "git.autofetch" = true;
      "git.confirmSync" = false;

      # nix
      "nixpkgs" = {
        expr = [ "import <nixpkgs> { }" ];
      };
      "nix.serverPath" = "nixd";
      "nix.enableLanguageServer" = true;
      "nix.serverSettings" = {
        "nixd" = {
          "formatting" = {
            "command" = [ "nixfmt" ]; # // or nixfmt or nixpkgs-fmt
          };
          "options" = {
            "nixos" = {
              "expr" = ''(builtins.getFlake "${settings.configDir}").nixosConfigurations.system.options'';
            };
            "home_manager" = {
              "expr" = ''(builtins.getFlake "${settings.configDir}").homeConfigurations.user.options'';
            };
          };
        };
      };

      "svelte.enable-ts-plugin" = true;
      # Prettier Everything
      "[html]" = prettier;
      "[css]" = prettier;
      "[json]" = prettier;
      "[jsonc]" = prettier;
      "[astro]" = prettier;
      "[svelte]" = prettier;
      "[markdown]" = prettier;
      "[javascript]" = prettier;
      "[javascriptreact]" = prettier;
      "[typescript]" = prettier;
      "[typescriptreact]" = prettier;

      "code-runner.runInTerminal" = true;
      # GOT THIS FROM THE INTERNET **
      "code-runner.executorMap" = {
        "javascript" = "${pkgs.nodejs}/bin/node";
        "java" =
          "cd $dir && ${pkgs.jre_minimal}/bin/javac $fileName && mv $fileNameWithoutExt $fileNameWithoutExt.o && ${pkgs.jre_minimal}/bin/java $fileNameWithoutExt.o";
        "c" =
          "cd $dir && ${pkgs.gcc}/bin/gcc $fileName -o $fileNameWithoutExt.o && $dir$fileNameWithoutExt.o";
        "cpp" =
          "cd $dir && ${pkgs.gcc}/bin/g++ $fileName -o $fileNameWithoutExt.o && $dir$fileNameWithoutExt.o";
        # "objective-c" = "cd $dir && gcc -framework Cocoa $fileName -o $fileNameWithoutExt.o && $dir$fileNameWithoutExt.o";
        # "php" = "${pkgs.php}/bin/php";
        # "python" = "${pkgs.python}/bin/python -u";
        # "perl" = "${pkgs.perl}/bin/perl";
        # "perl6" = "perl6";
        # "ruby" = "${pkgs.ruby}/bin/ruby";
        "go" = "${pkgs.go}/bin/go run";
        "lua" = "${pkgs.lua}/bin/lua";
        # "groovy" = "${pkgs.groovy}/bin/groovy";
        # "powershell" = "${pkgs.powershell}/bin/powershell -ExecutionPolicy ByPass -File";
        # "bat" = "cmd /c";
        "shellscript" = "${pkgs.bash}/bin/bash";
        # "fsharp" = "${pkgs.fsharp}/bin/fsi";
        # "csharp" = "scriptcs";
        # "vbscript" = "cscript //Nologo";
        # "typescript" = "${pkgs.nodePackages.typescript}/bin/ts-node";
        # "coffeescript" = "coffee";
        # "scala" = "${pkgs.scala}/bin/scala";
        # "swift" = "${pkgs.swift}/bin/swift";
        # "julia" = "${pkgs.julia}/bin/julia";
        # "crystal" = "${pkgs.crystal}/bin/crystal";
        # "ocaml" = "${pkgs.ocaml}/bin/ocaml";
        # "r" = "${pkgs.rWrapper}/bin/Rscript";
        # "applescript" = "osascript";
        # "clojure" = "${pkgs.clojure}/bin/lein exec";
        # "haxe" = "${pkgs.haxe}/bin/haxe --cwd $dirWithoutTrailingSlash --run $fileNameWithoutExt";
        # "rust" = "cd $dir && ${pkgs.rustc}/bin/rustc $fileName && mv $fileNameWithoutExt $fileNameWithoutExt.o && $dir$fileNameWithoutExt.o";
        # "racket" = "${pkgs.racket}/bin/racket";
        # "scheme" = "${pkgs.scheme48}/bin/csi -script";
        # "ahk" = "autohotkey";
        # "autoit" = "autoit3";
        # "dart" = "${pkgs.dart}/bin/dart";
        # "pascal" = "cd $dir && ${pkgs.fpc}/bin/fpc $fileName && mv $fileNameWithoutExt $fileNameWithoutExt.o && $dir$fileNameWithoutExt.o";
        # "d" = "cd $dir && dmd $fileName && mv $fileNameWithoutExt $fileNameWithoutExt.o && $dir$fileNameWithoutExt.o";
        # "haskell" = "${pkgs.haskell}/bin/runhaskell";
        # "nim" = "${pkgs.nim}/bin/nim compile --verbosity:0 --hints:off --run";
        # "lisp" = "${pkgs.lisp}/bin/sbcl --script";
        # "kit" = "kitc --run";
        # "v" = "${pkgs.vlang}/bin/v run";
        # "sass" = "${pkgs.sass}/bin/sass --style expanded";
        # "scss" = "${pkgs.sass}/bin/scss --style expanded";
        # "less" = "cd $dir && ${pkgs.lessc}/bin/lessc $fileName $fileNameWithoutExt.css";
        # "FortranFreeForm" = "cd $dir && gfortran $fileName -o $fileNameWithoutExt.o && $dir$fileNameWithoutExt.o";
        # "fortran-modern" = "cd $dir && ${pkgs.gfortran}/bin/gfortran $fileName -o $fileNameWithoutExt.o && $dir$fileNameWithoutExt.o";
        # "fortran_fixed-form" = "cd $dir && gfortran $fileName -o $fileNameWithoutExt.o && $dir$fileNameWithoutExt.o";
        # "fortran" = "cd $dir && ${pkgs.gfortran}/bin/gfortran $fileName -o $fileNameWithoutExt.o && $dir$fileNameWithoutExt.o";
      };
    };
    profiles.default.extensions =
      with pkgs.vscode-extensions;
      # with pkgs.vscode-marketplace;
      [
        redhat.java

        # formulahendry.code-runner

        bradlc.vscode-tailwindcss
        esbenp.prettier-vscode
        dbaeumer.vscode-eslint

        denoland.vscode-deno
        astro-build.astro-vscode
        svelte.svelte-vscode
        jnoortheen.nix-ide
        # yzhang.markdown-all-in-one
        # shd101wyy.markdown-preview-enhanced

        usernamehw.errorlens
        mechatroner.rainbow-csv
        eamodio.gitlens

        catppuccin.catppuccin-vsc-icons
      ];
    # };
  };
  home.packages = [
    pkgs.vscode # microsoft vscode
    pkgs.nixpkgs-fmt
    # pkgs.nixfmt
  ];
}
