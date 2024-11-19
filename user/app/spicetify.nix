{
  inputs,
  pkgs,
  config,
  ...
}:
{
  imports = [ inputs.spicetify.homeManagerModules.default ];
  programs.spicetify =
    let
      spicePkgs = inputs.spicetify.legacyPackages.${pkgs.system};
    in
    {
      enable = true;
      theme = spicePkgs.themes.text;
      colorScheme = "custom";

      # customColorScheme = with config.lib.stylix.colors; {
      #   text = "${base05}";
      #   subtext = "${base05}";
      #   sidebar-text = "${base05}";
      #   main = "${base00}";
      #   sidebar = "${base01}";
      #   player = "${base01}";
      #   card = "${base00}";
      #   shadow = "${base03}";
      #   selected-row = "${base03}";
      #   button = "${base0F}";
      #   button-active = "${base05}";
      #   button-disabled = "${base0E}";
      #   tab-active = "${base03}";
      #   notification = "${base0A}";
      #   notification-error = "${base0F}";
      #   misc = "${base05}";
      #   alt-text = "${base05}";
      #   player-bar-bg = "${base01}";
      #   accent = "${base06}";
      # };

      customColorScheme = with config.lib.stylix.colors; {
        text = "${base05}";
        subtext = "${base05}";
        sidebar-text = "${base07}";
        main = "${base00}";
        main-elevated = "${base02}";
        highlight = "${base02}";
        highlight-elevated = "${base03}";
        sidebar = "${base01}";
        player = "${base0A}";
        card = "${base04}";
        shadow = "${base00}";
        selected-row = "${base0A}";
        button = "${base0B}";
        button-active = "${base05}";
        button-disabled = "${base04}";
        tab-active = "${base02}";
        notification = "${base02}";
        notification-error = "${base08}";
        equalizer = "${base0D}";
        misc = "${base0C}";
      };

      enabledCustomApps = with spicePkgs.apps; [
        newReleases
        lyricsPlus
      ];

      enabledExtensions = with spicePkgs.extensions; [
        # fullAppDisplay
        hidePodcasts
      ];
    };

}
