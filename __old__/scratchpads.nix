{ lib, userSettings, ... }:
{

  wayland.windowManager.hyprland.settings.bind = [
    "ALT,Z,exec,pypr toggle term && hyprctl dispatch bringactivetotop"
    "$mainMod, W,exec,pypr toggle whatsapp && hyprctl dispatch bringactivetotop"
    "$mainMod,G,exec,pypr toggle openai && hyprctl dispatch bringactivetotop"
    "$mainMod,S,exec,pypr toggle music && hyprctl dispatch bringactivetotop"

    "$mainMod,F,exec,pypr toggle nemo && hyprctl dispatch bringactivetotop"

    "$mainMod,P,exec,pypr toggle postman && hyprctl dispatch bringactivetotop"
  ];

  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = ["scratchpads", "magnify"]

    # [scratchpads.term2]
    # animation = "fromBottom"
    # command = "${userSettings.term}"
    # class = "nemo"
    # size = "85% 85%"

    [scratchpads.term]
    animation = "fromBottom"
    command = "ghostty"
    class = "com.mitchellh.ghostty"
    size = "85% 85%"

    [scratchpads.nemo]
    animation = "fromBottom"
    command = "nemo"
    class = "nemo"
    lazy = true
    size = "85% 85%"

    [scratchpads.postman]
    animation = "fromRight"
    command = "postman"
    class = "Postman"
    lazy = true
    size = "55% 85%"

    [scratchpads.volume]
    animation = "fromRight"
    command = "pavucontrol"
    class = "pavucontrol"
    lazy = true
    size = "25% 60%"
    position = "70% 5%"
    unfocus = "hide"
    hysteresis=2


    [scratchpads.music]
    animation = "fromRight"
    command = "spotify"
    class = "spotify"
    size = "45% 85%"
    unfocus = "hide"
    hysteresis=2

    [scratchpads.openai]
    animation = "fromRight"
    match_by = "title"
    title =  "re:.*ChatGPT — Zen Browser.*"
    command = "zen -P Apps --new-window https://chat.openai.com/"
    size = "45% 85%"
    process_tracking = false

    [scratchpads.whatsapp]
    animation = "fromLeft"
    match_by = "title"
    title = "re:.*WhatsApp — Zen Browser.*"
    command = "zen -P Apps --new-window https://web.whatsapp.com/"
    size = "75% 60%"
    process_tracking = false
  '';

}
