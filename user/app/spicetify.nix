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
      theme = spicePkgs.themes.comfy;
      colorScheme = "custom";

      customColorScheme = with config.lib.stylix.colors; {
        text = "${base05}";
        subtext = "${base05}";
        sidebar-text = "${base05}";
        main = "${base00}";
        sidebar = "${base01}";
        player = "${base01}";
        card = "${base00}";
        shadow = "${base03}";
        selected-row = "${base03}";
        button = "${base0F}";
        button-active = "${base05}";
        button-disabled = "${base0E}";
        tab-active = "${base03}";
        notification = "${base0A}";
        notification-error = "${base0F}";
        misc = "${base05}";
        alt-text = "${base05}";
        player-bar-bg = "${base01}";
        accent = "${base06}";
      };

      # customColorScheme = {
      #   text = "${config.lib.stylix.colors.base05}";
      #   subtext = "${config.lib.stylix.colors.base05}";
      #   sidebar-text = "${config.lib.stylix.colors.base07}";
      #   main = "${config.lib.stylix.colors.base00}";
      #   sidebar = "${config.lib.stylix.colors.base00}";
      #   player = "${config.lib.stylix.colors.base0D}";
      #   card = "${config.lib.stylix.colors.base02}";
      #   shadow = "${config.lib.stylix.colors.base01}";
      #   selected-row = "${config.lib.stylix.colors.base02}";
      #   button = "${config.lib.stylix.colors.base0D}";
      #   button-active = "${config.lib.stylix.colors.base0D}";
      #   button-disabled = "${config.lib.stylix.colors.base02}";
      #   tab-active = "${config.lib.stylix.colors.base0D}";
      #   notification = "${config.lib.stylix.colors.base0B}";
      #   notification-error = "${config.lib.stylix.colors.base08}";
      #   misc = "${config.lib.stylix.colors.base02}";
      # };

      # enabledCustomApps = with spicePkgs.apps; [
      #   newReleases
      #   lyricsPlus
      # ];

      # enabledExtensions = with spicePkgs.extensions; [
      #   fullAppDisplay
      #   hidePodcasts
      # ];
    };

}
