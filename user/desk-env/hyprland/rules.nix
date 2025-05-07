{ userSettings, ... }:
{
  wayland.windowManager.hyprland.settings = {
    # windowrule =
    #   let
    #     f = regex: "float, ^(${regex})$";
    #   in
    #   [
    #     (f "org.gnome.Calculator")
    #     (f "org.gnome.Nautilus")
    #     (f "pavucontrol")
    #     (f "nm-connection-editor")
    #     (f "blueberry.py")
    #     (f "org.gnome.Settings")
    #     (f "org.gnome.design.Palette")
    #     (f "xdg-desktop-portal")
    #     (f "xdg-desktop-portal-gnome")
    #     (f "transmission-gtk")
    #     (f "Bitwarden")
    #     (f "spotify")
    #     (f ".blueman-manager-wrapped")
    #     (f "brave-web.whatsapp.com__-Default")
    #     (f "brave-chat.openai.com__-Default")
    #     (f "brave-notion.so__-Default")
    #     (f "brave-nngceckbapebfimnlniiiahkandclblb-Default") # Bitwarden
    #     # (.*)(- Youtube)
    #     "float, title:(.*GPT.*)"
    #     "float, title:(.*)(WhatsApp — Zen Browser)"
    #     "float, title:(.*WhatsApp.*)"

    #   ];
    workspace = [
      #these apps will open on the specified workspace when you firt open them
      "8, on-created-empty:discord"
      "9, on-created-empty:thunderbird"
      # "special:exposed,gapsout:60,gapsin:30,bordersize:5,border:true,shadow:false"
      # Smart gaps
      "w[tv1], gapsout:0, gapsin:0E"
      "f[1], gapsout:0, gapsin:0"
    ];
    windowrulev2 = [

      # Smart Gaps
      "bordersize 0, floating:0, onworkspace:w[tv1]"
      "rounding 0, floating:0, onworkspace:w[tv1]"
      "bordersize 0, floating:0, onworkspace:f[1]"
      "rounding 0, floating:0, onworkspace:f[1]"

      # PIP
      "float, title:^Picture-in-Picture$"
      "pin, title:^Picture-in-Picture$"
      "noinitialfocus, title:^Picture-in-Picture$"
      "move 69% 69%, title:^Picture-in-Picture$"
      "opacity 1.0 1.0, title:^Picture-in-Picture$"


      # other
      "group set, initialClass:zen-twilight"
    ];

  };
}
