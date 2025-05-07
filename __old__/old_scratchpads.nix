{
  userSettings,
  lib,
  pkgs,
}:
let
  braveLauncher = url: "brave --profile-directory=Default --app=${url}";

  # zenLauncher = url: "zen -P Apps --new-window ${url}";
  zenLauncher = url: "zen -P Apps --new-window ${url}";

  # zenLauncher = title: url: pkgs.writeShellScriptBin "init-${title}" ''
  #   if ! hyprctl -j clients | jq -e --arg title "${title}" '.[] | select(.title | test($title; "i"))'; then
  #     zen -P Apps --new-window ${url}
  #   fi
  # '';

in
# zenLauncher2 =
#   title: url:
#   ''if ! hyprctl -j clients | jq -e '.[] | select(.title | test("${title}"; "i"))'; then zen -P Apps --new-window "${url}"; fi'';
[
  {
    bind = "ALT,Z,exec,pypr toggle term && hyprctl dispatch bringactivetotop";
    scratchpad = ''
      [scratchpads.term]
      animation = "fromBottom"
      command = "${userSettings.term} --class dropterm"
      class = "dropterm"
      size = "85% 85%"
    '';
  }
  # {
  #   bind = "$mainMod, F,exec,pypr toggle filemanager && hyprctl dispatch bringactivetotop";
  #   scratchpad = ''
  #     [scratchpads.filemanager]
  #     animation = "fromRight"
  #     command = "nautilus"
  #     class = "nautilus"
  #     size = "45% 75%"
  #   '';
  # }
  # {
  #   bind = "$mainMod,V,exec,pypr toggle volume && hyprctl dispatch bringactivetotop";
  #   scratchpad = ''
  #     [scratchpads.volume]
  #     animation = "fromRight"
  #     command = "pavucontrol"
  #     class = "pavucontrol"
  #     lazy = true
  #     size = "25% 60%"
  #     position = "70% 5%"
  #     unfocus = "hide"
  #     hysteresis=2
  #   '';
  # }
  # {
  #   bind = "$mainMod, P,exec,pypr toggle network && hyprctl dispatch bringactivetotop";
  #   scratchpad = ''
  #     [scratchpads.network]
  #     animation = "fromRight"
  #     command = "nm-connection-editor"
  #     class = "nm-connection-editor"
  #     lazy = true
  #     size = "25% 60%"
  #     position = "70% 5%"
  #   '';
  # }
  # {
  #   # bluetooth
  #   bind = "$mainMod, B,exec,pypr toggle bluetooth && hyprctl dispatch bringactivetotop";
  #   scratchpad = ''
  #     [scratchpads.bluetooth]
  #     animation = "fromRight"
  #     command = "blueman-manager"
  #     class = "blueman-manager"
  #     lazy = true
  #     size = "25% 60%"
  #     position = "70% 5%"
  #     unfocus = "hide"
  #     hysteresis=2

  #   '';
  # }
  # {
  #   bind = "$mainMod,S,exec,pypr toggle music && hyprctl dispatch bringactivetotop";
  #   scratchpad = ''
  #     [scratchpads.music]
  #     animation = "fromRight"
  #     command = "spotify"
  #     class = "spotify"
  #     size = "45% 85%"
  #     unfocus = "hide"
  #     hysteresis=2
  #   '';
  # }
  # {
  #   bind = "$mainMod,B,exec,pypr toggle bitwarden && hyprctl dispatch bringactivetotop";
  #   scratchpad = ''
  #     [scratchpads.bitwarden]
  #     animation = "fromTop"
  #     command = "bitwarden"
  #     class = "bitwarden"
  #     size = "45% 70%"
  #     unfocus = "hide"
  #     hysteresis=2
  #   '';
  # }
  # -----------------------------
  # *Tip use SUPER + J to get the name of the class
  # -----------------------------
  # {
  #   bind = "$mainMod, W,exec,pypr toggle whatsapp && hyprctl dispatch bringactivetotop";
  #   scratchpad = ''
  #     [scratchpads.whatsapp]
  #     animation = "fromLeft"
  #     match_by = "title"
  #     title = "re:.*WhatsApp — Zen Browser.*"
  #     command = "${zenLauncher "https://web.whatsapp.com/"}"
  #     size = "75% 60%"
  #     process_tracking = false
  #   '';
  # }
  # {
  #   bind = "$mainMod,G,exec,pypr toggle openai && hyprctl dispatch bringactivetotop";
  #   scratchpad = ''
  #     [scratchpads.openai]
  #     animation = "fromRight"
  #     match_by = "title"
  #     title =  "re:.*ChatGPT — Zen Browser.*"
  #     command = "${zenLauncher "https://chat.openai.com/"}"
  #     size = "45% 85%"
  #     process_tracking = false
  #   '';
  # }
  # {
  #   bind = "$mainMod,N,exec,pypr toggle notion && hyprctl dispatch bringactivetotop";
  #   scratchpad = ''
  #     [scratchpads.notion]
  #     animation = "fromLeft"
  #     command = "brave --profile-directory=Default --app=https://notion.so"
  #     class = "brave-notion.so__-Default"
  #     size = "95% 85%"
  #     process_tracking = false
  #   '';
  # }
  # {
  #   bind = "$mainMod,P,exec,pypr toggle proton && hyprctl dispatch bringactivetotop";
  #   scratchpad = ''
  #     [scratchpads.proton]
  #     animation = "fromLeft"
  #     command = "brave --profile-directory=Default --app=https://mail.proton.me/u/2/inbox"
  #     class = "brave-mail.prton.me__u_2_inbox-Default"
  #     size = "95% 85%"
  #     process_tracking = false
  #   '';
  # }
]
