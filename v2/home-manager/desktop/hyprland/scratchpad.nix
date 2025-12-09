{
  lib,
  config,
  ...
}:
{
  imports = [
    ../../../modules/home-manager/scratchpad.nix
  ];

  scratchpads = [
    {
      name = "term";
      animation = "fromBottom";
      command = "ghostty";
      class = "com.mitchellh.ghostty";
      size = "85% 85%";
      bind = "ALT,Z";
    }
    {
      name = "nemo";
      animation = "fromBottom";
      command = "nemo";
      class = "nemo";
      lazy = true;
      size = "85% 85%";
      bind = "$mainMod,F";
    }
    {
      name = "volume";
      animation = "fromRight";
      command = "pavucontrol";
      class = "pavucontrol";
      lazy = true;
      size = "25% 60%";
      position = "70% 5%";
      unfocus = "hide";
    }
    {
      name = "music";
      animation = "fromRight";
      command = "spotify";
      class = "spotify";
      lazy = true;
      size = "45% 85%";
      unfocus = "hide";
      bind = "$mainMod,S";
    }
    # {
    #   name = "mail";
    #   animation = "fromRight";
    #   command = "proton-mail";
    #   class = "Proton Mail";
    #   size = "45% 85%";
    #   unfocus = "hide";
    #   bind = "$mainMod,M";
    #   lazy = true;
    # }
    # {
    #   name = "openai";
    #   animation = "fromRight";
    #   match_by = "title";
    #   title = "re:.*ChatGPT — Zen Browser.*";
    #   command = "zen -P Apps --new-window https://chat.openai.com/";
    #   size = "45% 85%";
    #   bind = "$mainMod,G";
    #   lazy = true;
    # }
    {
      name = "whatsapp";
      animation = "fromLeft";
      match_by = "title";
      title = "re:web.whatsapp.com.*";
      command = "chromium --app=https://web.whatsapp.com/";
      size = "75% 60%";
      bind = "ALT,W";
      lazy = true;
    }
  ];
}
