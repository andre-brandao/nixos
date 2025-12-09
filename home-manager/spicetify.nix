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

      customColorScheme = with config.lib.stylix.colors; {
        text = "${base05}"; # Lighter color for text
        subtext = "${base05}"; # Slightly darker than text
        sidebar-text = "${base07}"; # Same as text for consistency
        main = "${base00}"; # Dark background
        main-elevated = "${base03}"; # Slightly lighter than main
        highlight = "${base02}"; # Bright color for highlight
        highlight-elevated = "${base03}"; # Slightly different bright color
        sidebar = "${base01}"; # Darker than main-elevated
        player = "${base05}"; # Bright color for player
        card = "${base04}"; # Slightly lighter than sidebar
        shadow = "${base00}"; # Same as main for consistency
        selected-row = "${base05}"; # Bright color for selected row
        button = "${base05}"; # Bright color for button
        button-active = "${base0A}"; # Different bright color for active button
        button-disabled = "${base04}"; # Muted color for disabled button
        tab-active = "${base02}"; # Bright color for active tab
        notification = "${base02}"; # Bright color for notification
        notification-error = "${base08}"; # Red color for error notification
        equalizer = "${base0D}"; # Bright color for equalizer
        misc = "${base0F}"; # Different bright color for miscellaneous
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
