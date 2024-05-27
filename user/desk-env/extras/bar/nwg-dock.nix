{config, ...}:{
  home.file.".config/nwg-dock-hyprland/style.css".text = ''
    window {
      background: rgba(''+config.lib.stylix.colors.base00-rgb-r+'',''+config.lib.stylix.colors.base00-rgb-g+'',''+config.lib.stylix.colors.base00-rgb-b+'',0.0);
      border-radius: 20px;
      padding: 4px;
      margin-left: 4px;
      margin-right: 4px;
      border-style: none;
    }

    #box {
      /* Define attributes of the box surrounding icons here */
      padding: 10px;
      background: rgba(''+config.lib.stylix.colors.base00-rgb-r+'',''+config.lib.stylix.colors.base00-rgb-g+'',''+config.lib.stylix.colors.base00-rgb-b+'',0.55);
      border-radius: 20px;
      padding: 4px;
      margin-left: 4px;
      margin-right: 4px;
      border-style: none;
    }
    button {
      border-radius: 10px;
      padding: 4px;
      margin-left: 4px;
      margin-right: 4px;
      background: rgba(''+config.lib.stylix.colors.base03-rgb-r+'',''+config.lib.stylix.colors.base03-rgb-g+'',''+config.lib.stylix.colors.base03-rgb-b+'',0.55);
      color: #''+config.lib.stylix.colors.base07+'';
      font-size: 12px
    }

    button:hover {
      background: rgba(''+config.lib.stylix.colors.base04-rgb-r+'',''+config.lib.stylix.colors.base04-rgb-g+'',''+config.lib.stylix.colors.base04-rgb-b+'',0.55);
    }

  '';
  home.file.".config/nwg-dock-pinned".text = ''
    Alacritty
    brave-browser
    librewolf
    writer
    impress
    calc
    draw
    xournalpp
    obs
    kdenlive
    blender
    openscad
    Cura
    virt-manager
  '';
}