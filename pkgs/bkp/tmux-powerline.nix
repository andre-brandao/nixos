{ pkgs, fetchFromGitHub, ... }:
pkgs.tmuxPlugins.mkTmuxPlugin {
  pluginName = "tmux-powerline";
  version = "3.0.0";
  rtpFilePath = "main.tmux";

  src = fetchFromGitHub {
    owner = "erikw";
    repo = "tmux-powerline";
    rev = "2480e55";
    hash = "sha256-25uG7OI8OHkdZ3GrTxG1ETNeDtW1K+sHu2DfJtVHVbk=";
  };
}
