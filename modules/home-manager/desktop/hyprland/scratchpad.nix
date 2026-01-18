{
  lib,
  config,
  ...
}:
{
  imports = [
    ./modules/scratchpad.nix
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
    {
      name = "whatsapp";
      animation = "fromLeft";
      match_by = "class";
      process_tracking = false;
      # match_by = "initialClass";
      # initialTitle = "web.whatsapp.com_/";
      # initialClass = "brave-web.whatsapp.com__-Default";
      class = "brave-web.whatsapp.com__-Default";
      # title = "re:web.whatsapp.com.*";
      command = "brave --profile-directory=Default --app=https://web.whatsapp.com/";
      size = "75% 60%";
      bind = "ALT,W";
      lazy = true;
    }
    {
      name = "a3chat";
      animation = "fromLeft";
      process_tracking = false;
      # match_by = "class";
      match_by = "initialClass";
      # initialTitle = "web.whatsapp.com_/";
      initialClass = "brave-mail.google.com__chat_-A3";
      class = "brave-mail.google.com__chat_-A3";
      command = "brave --profile-directory=A3 --app=https://mail.google.com/chat/";
      size = "85% 70%";
      bind = "ALT,C";
      lazy = true;
    }
    {
      name = "claudinho";
      animation = "fromRight";
      process_tracking = false;
      # match_by = "class";
      match_by = "initialClass";
      # initialTitle = "web.whatsapp.com_/";
      initialClass = "brave-claude.ai__new_-Default";
      class = "brave-claude.ai__new_-Default";
      command = "brave --profile-directory=Default --app=https://claude.ai/new/";
      size = "90% 90%";
      bind = "$mainMod,C";
      lazy = true;
    }
  ];

  wayland.windowManager.hyprland.settings.windowrule = [
    "float on, match:initial_class brave-nngceckbapebfimnlniiiahkandclblb-Default"
    "float on, match:initial_class brave-web.whatsapp.com__-Default"
    "float on, match:initial_class brave-mail.google.com__chat_-A3"
    "float on, match:initial_class brave-claude.ai__new_-Default"
  ];
}
