{ pkgs, lib, ... }:
{
  imports = (
    map lib.custom.relativeToRoot [
      "home-manager/shell/shell.nix"
    ]
  );
  # programs.zsh = {
  #   enable = true;
  #   autocd = true;
  #   enableCompletion = true;
  #   autosuggestion.enable = true;
  #   syntaxHighlighting.enable = true;
  #   initContent = ''
  #     source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
  #     POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
  #     bindkey '^w' forward-word
  #     bindkey '^b' backward-kill-word
  #     bindkey '^f' autosuggest-accept
  #   '';
  # };

  home.username = "andre";
  home.homeDirectory = "/home/andre";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    openssl
  ];
}
