{ pkgs, userSettings, ... }:
{
  xdg.desktopEntries.nemo = {
    name = "Nemo";
    exec = "${pkgs.nemo-with-extensions}/bin/nemo";
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "nemo.desktop" ];
      "application/x-gnome-saved-search" = [ "nemo.desktop" ];
    };
  };
  dconf = {
    settings = {
      "org/cinnamon/desktop/applications/terminal" = {
        exec = userSettings.term;
        # exec-arg = ""; # argument
      };
    };
  };

}
