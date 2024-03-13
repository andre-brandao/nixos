{pkgs, config, inputs, ...}:{
  imports = [
    inputs.homeManagerModules.nixvim
  ];


  programs.nixvim = {
    enable = true;
  };
}