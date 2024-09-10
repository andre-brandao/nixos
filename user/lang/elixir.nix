{ pkgs, ... }:
{
  home.packages = with pkgs; [
    elixir
    erlang
    inotify-tools

  ];
}
