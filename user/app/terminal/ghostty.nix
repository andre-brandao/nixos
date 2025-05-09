{ pkgs, ... }:
{
  # https://nixos-and-flakes.thiscute.world/best-practices/accelerating-dotfiles-debugging
  home.file.".config/ghostty/config".text = ''
    theme = deep
    # window-theme = ghostty
    background-opacity = 0.8
    window-decoration = false


    ## KEYBINDS

    keybind = ctrl+-=new_split:down

    keybind = ctrl+\=new_split:right
    keybind = ctrl+]=new_split:right

    keybind = ctrl+up=goto_split:top
    keybind = ctrl+down=goto_split:bottom
    keybind = ctrl+left=goto_split:left
    keybind = ctrl+right=goto_split:right

    keybind = ctrl+w=close_surface

    keybind = ctrl+t=new_tab
    keybind = ctrl+n=next_tab
    keybind = ctrl+shift+n=previous_tab

    keybind = ctrl+shift+space=toggle_tab_overview
    ## prevent from opening are you sure you want to quit
    confirm-close-surface = false
  '';
}
