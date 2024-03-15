{
  inputs,
  lib,
  config,
  pkgs,
  nixvim,
  userSettings,
  ...
}: {
  programs = {
    neovim = {
      enable = true;
      extraConfig = ''
        set number relativenumber
        set shiftwidth=2
        set tabstop=2
        set expandtab
        set autoindent
        set smartindent
        set smarttab

        # colorscheme blue
      '';
    };
  };
}
