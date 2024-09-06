{ pkgs,inputs, ... }:

{
  # Module installing brave as default browser
  home.packages =[ inputs.zen-browser.packages."${pkgs.system}".specific ];

  # xdg.mimeApps.defaultApplications = {
  # "text/html" = "brave-browser.desktop";
  # "x-scheme-handler/http" = "brave-browser.desktop";
  # "x-scheme-handler/https" = "brave-browser.desktop";
  # "x-scheme-handler/about" = "brave-browser.desktop";
  # "x-scheme-handler/unknown" = "brave-browser.desktop";
  # };

  home.sessionVariables = {
    DEFAULT_BROWSER = "zen";
  };

}