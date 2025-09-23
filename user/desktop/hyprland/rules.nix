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

      # # Smart gaps
      "w[tv1]s[false], gapsout:0, gapsin:0"
      "f[1]s[false], gapsout:0, gapsin:0"
      # drawing
      "special:gromit, gapsin:0, gapsout:0, on-created-empty: gromit-mpx -a"
    ];
    windowrule = [
      # # Smart Gaps
      "bordersize 0, floating:0, onworkspace:w[tv1]s[false]"
      "rounding 0, floating:0, onworkspace:w[tv1]s[false]"
      "bordersize 0, floating:0, onworkspace:f[1]s[false]"
      "rounding 0, floating:0, onworkspace:f[1]s[false]"

      "float, title:^DedsLauncher$"
      "pin, title:^DedsLauncher$"
      # PIP
      "float, title:^Picture-in-Picture$"
      "pin, title:^Picture-in-Picture$"
      "noinitialfocus, title:^Picture-in-Picture$"
      "move 69% 69%, title:^Picture-in-Picture$"
      "opacity 1.0 1.0, title:^Picture-in-Picture$"

      # Proton vpn ## title = Proton VPN initialClass = .protonvpn-app-wrapped
      "float, title:^Proton VPN$"
      "pin, title:^Proton VPN$"
      "noinitialfocus, title:^Proton VPN$"
      "move 10% 10%, title:^Proton VPN$"
      "opacity 1.0 1.0, title:^Proton VPN$"
      "size 20% 50%, title:^Proton VPN$"

      # other
      "group set, initialClass:zen-twilight"
      # drawing
      #
      "noblur, class:^Gromit-mpx$"
      "noshadow, class:^Gromit-mpx$"
      "opacity 1 override 1 override, class:^Gromit-mpx$"
      "size 100% 100%, class:^Gromit-mpx$"

    ];

  };
}
