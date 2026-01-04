{
  python = {
    path = ./python;
    description = "Python template, using poetry2nix";
    welcomeText = ''
      # Getting started
      - Run `nix develop`
      - Run `poetry run python -m sample_package`
    '';
  };

  latexmk = {
    path = ./latexmk;
    description = "A simple LaTeX template for writing documents with latexmk";
  };

  go = {
    path = ./go;
    description = "Go Template";
    welcomeText = ''
      # Getting started
      - Run `nix develop`
      - Run `go run main.go`
    '';
  };

  bun-desktop = {
    path = ./bun/desktop;
    description = "A development shell for bun desktop applications";
    welcomeText = ''
      # Getting started
      - Run `nix develop`
      - Run `bun run <your-file>.ts`
    '';
  };
}
