{ lib, userSettings, ... }:
let

  makeScratchpad =
    cfg: with cfg; ''
      bind = "$mainMod,${key},togglespecialworkspace,${name}"

      $${name} = class:^(${class})$
      windowrulev2 = float,$${name}
      windowrulev2 = size ${width} ${height},$${name}
      windowrulev2 = workspace special:${name} silent,$${name}
      windowrulev2 = center,$${name}
      workspace = special:${name}, on-created-empty:${command}
    '';

  scratchpads = [
    # {
    #   name = "scratch_term";
    #   class = "scratch_term";
    #   command = "alacritty --class scratch_term";
    #   key = "I";
    #   width = "50%";
    #   height = "50%";
    # }
    # {
    #   name = "spotify";
    #   class = "Spotify";
    #   command = "spotify";
    #   key = "S";
    #   width = "45%";
    #   height = "85%";

    # }
    {
      name = "scratch_filemanager";
      class = "scratch_filemanager";
      command = "nautilus";
      key = "F";
      width = "45%";
      height = "75%";
    }
    # {
    #   name = "whatsapp";
    #   class = "brave-web.whatsapp.com__-Default";
    #   command = "brave --profile-directory=Default --app=https://web.whatsapp.com";
    #   key = "W";
    #   width = "75%";
    #   height = "60%";
    # }
    # {
    #   name = "gpt";
    #   class = "brave-chat.openai.com__-Default";
    #   command = "brave --profile-directory=Default --app=https://chat.openai.com";
    #   key = "G";
    #   width = "45%";
    #   height = "85%";
    # }

  ];

in
{

  # animation = "specialWorkspace, 1, 6, default, slidefadevert -50%";

  # toString = pads: lib.concatStringsSep "\n" (map makeScratchpad scratchpads);

  wayland.windowManager.hyprland.extraConfig = lib.concatStringsSep "\n" (
    map makeScratchpad scratchpads
  );

  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = ["scratchpads", "magnify"]

    [scratchpads.term]
    animation = "fromBottom"
    command = "${userSettings.term} --class dropterm"
    class = "dropterm"
    size = "85% 85%"

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
