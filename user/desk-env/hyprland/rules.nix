{userSettings,...}:{
  wayland.windowManager.hyprland.settings = {
      windowrule =
        let
          f = regex: "float, ^(${regex})$";
        in
        [
          (f "org.gnome.Calculator")
          (f "org.gnome.Nautilus")
          (f "pavucontrol")
          (f "nm-connection-editor")
          (f "blueberry.py")
          (f "org.gnome.Settings")
          (f "org.gnome.design.Palette")
          (f "xdg-desktop-portal")
          (f "xdg-desktop-portal-gnome")
          (f "transmission-gtk")
          (f "Bitwarden")
          (f "Spotify")
          (f ".blueman-manager-wrapped")
          (f "brave-web.whatsapp.com__-Default")
          (f "brave-chat.openai.com__-Default")
          (f "brave-notion.so__-Default")
          (f "brave-nngceckbapebfimnlniiiahkandclblb-Default") # Bitwarden
        ];


    workspace = [
        #these apps will open on the specified workspace when you firt open them
        "8, on-created-empty:vesktop"
        "9, on-created-empty:thunderbird"
        # "special:exposed,gapsout:60,gapsin:30,bordersize:5,border:true,shadow:false"
      ];

  };
}