{ pkgs, inputs, ... }:

let
  zen-browser = inputs.zen-browser.packages.${pkgs.system}.twilight.override {
    nativeMessagingHosts = [ pkgs.firefoxpwa ];
  };
in

{
  # Module installing brave as default browser
  home.packages = [ zen-browser ];

  # home.sessionVariables = {
  #   DEFAULT_BROWSER = "zen";
  # };

  xdg.mimeApps =
    let
      value = zen-browser.meta.desktopFileName;
      associations = builtins.listToAttrs (
        map
          (name: {
            inherit name value;
          })
          [
            "application/x-extension-shtml"
            "application/x-extension-xhtml"
            "application/x-extension-html"
            "application/x-extension-xht"
            "application/x-extension-htm"
            "x-scheme-handler/unknown"
            "x-scheme-handler/mailto"
            "x-scheme-handler/chrome"
            "x-scheme-handler/about"
            "x-scheme-handler/https"
            "x-scheme-handler/http"
            "application/xhtml+xml"
            "application/json"
            "text/plain"
            "text/html"
          ]
      );
    in
    {
      associations.added = associations;
      defaultApplications = associations;
    };

}
