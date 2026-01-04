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
}
