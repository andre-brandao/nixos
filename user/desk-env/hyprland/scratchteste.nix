{
  lib,
  userSettings,
  config,
  ...
}:
{
  imports = [
    ./modules/scratchpad.nix
  ];

  options.scratchpads = [
    {
      name = "term";
      bind = "ALT,Z";
      animation = "fromBottom";
      command = "ghostty";
      class = "com.mitchellh.ghostty";
      size = "85% 85%";
    }
    {
      name = "nemo";
      bind = "$mainMod,F";
      animation = "fromBottom";
      command = "nemo";
      class = "nemo";
      lazy = true;
      size = "85% 85%";
    }
    {
      name = "postman";
      bind = "$mainMod,P";
      animation = "fromRight";
      command = "postman";
      class = "Postman";
      lazy = true;
      size = "55% 85%";
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
      bind = "$mainMod,S";
      animation = "fromRight";
      command = "spotify";
      class = "spotify";
      size = "45% 85%";
      unfocus = "hide";
    }
    {
      name = "openai";
      bind = "$mainMod,G";
      animation = "fromRight";
      command = "zen -P Apps --new-window https://chat.openai.com/";
      size = "45% 85%";
    }
    {
      name = "whatsapp";
      bind = "$mainMod,W";
      animation = "fromLeft";
      command = "zen -P Apps --new-window https://web.whatsapp.com/";
      size = "75% 60%";
    }
  ];
}
