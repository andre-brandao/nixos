{ pkgs, inputs, ... }:
{
  imports = [
    inputs.walker.homeManagerModules.default
    # inputs.elephant.homeManagerModules.default
  ];
  # programs.elephant = {
  #   enable = true;
  #   settings = {};
  # };
  programs.walker = {
    enable = true;
    runAsService = true;

    # Configuration options
    config = {
      theme = "default";
      placeholders = {
        default = {
          input = "Search";
          list = "No Results";
        };
        "desktopapplications" = {
          input = "Launch App";
          list = "No Applications";
        };
        "files" = {
          input = "Browse Files";
          list = "No Files Found";
        };
        "calc" = {
          input = "Calculate";
          list = "Enter Expression";
        };
        "runner" = {
          input = "Run Command";
          list = "No Commands";
        };
        "websearch" = {
          input = "Search Web";
          list = "";
        };
        "clipboard" = {
          input = "Clipboard";
          list = "Clipboard Empty";
        };
        "symbols" = {
          input = "Symbol";
          list = "No Symbols";
        };
        "todo" = {
          input = "Todo";
          list = "No Todos";
        };
      };
      providers = {
        actions = {
          files = [
            {
              action = ''%${pkgs.dragon-drop}/bin/xdragon -a -x "$fx"'';
              bind = "ctrl d";
              label = "Drag and Drop";
            }
          ];
        };
        # prefixes = [
        #   # {
        #   #   provider = "websearch";
        #   #   prefix = "+";
        #   # }
        #   # {
        #   #   provider = "providerlist";
        #   #   prefix = "_";
        #   # }
        # ];
      };
      # keybinds.quick_activate = [
      #   "F1"
      #   "F2"
      #   "F3"
      # ];
    };

    # Custom theme
    # themes = {
    #   "my-theme" = {
    #     style = ''
    #       /* Your CSS here */
    #     '';
    #     layouts = {
    #       "layout" = ''<!-- Your XML layout -->'';
    #     };
    #   };
    # };
  };

  home.file.".config/elephant/menus/other.toml".text = ''
    name = "other"
    name_pretty = "Other"
    icon = "applications-other"

    [[entries]]
    text = "Color Picker"
    keywords = ["color", "picker", "hypr"]
    actions = { "cp_use" = "wl-copy $(hyprpicker)" }
    icon = "color-picker"

    [[entries]]
    icon = "zoom-in"
    text = "Zoom Toggle"
    actions = { "zoom_use" = "hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float) | if . > 1 then 1 else 1.5 end')" }

    [[entries]]
    text = "Volume"
    async = "echo $(wpctl get-volume @DEFAULT_AUDIO_SINK@)"
    icon = "audio-volume-high"

    [entries.actions]
    "volume_raise" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+"
    "volume_lower" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"
    "volume_mute" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0"
    "volume_unmute" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1"
    "volume_set" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ %VALUE%"

    [[entries]]
    keywords = ["disk", "drive", "space"]
    text = "Disk"
    actions = { "disk_copy" = "wl-copy '%VALUE%'" }
    async = """echo $(df -h / | tail -1 | awk '{print "Used: " $3 " / " $4 " (" $2  ")"}')"""
    icon = "drive-harddisk"

    [[entries]]
    text = "Mic"
    async = "echo $(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)"
    icon = "audio-input-microphone"
    actions = { "mic_set" = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ %VALUE%" }

    [[entries]]
    text = "System"
    async = """echo $(echo "Memory: $(free -h | awk '/^Mem:/ {printf "%s/%s", $3, $2}') | CPU: $(top -bn1 | grep 'Cpu(s)' | awk '{printf "%.1f%%", 100 - $8}')")"""
    icon = "computer"

    [[entries]]
    text = "Today"
    keywords = ["date", "today", "calendar"]
    async = """echo $(date "+%H:%M - %d.%m. %A - KW %V")"""
    icon = "clock"
    actions = { "open_cal" = "xdg-open https://calendar.google.com" }

    [[entries]]
    text = "uuctl"
    keywords = ["uuctl"]
    icon = "applications-system"
    submenu = "dmenu:uuctl"
  '';

  home.file.".config/elephant/menus/screenshots.toml".text = ''
    name = "screenshots"
    name_pretty = "Screenshots"
    icon = "camera-photo"

    [[entries]]
    text = "View"
    actions = { "view" = "vimiv ~/Pictures/" }

    [[entries]]
    text = "Annotate"
    actions = { "annotate" = "wl-paste | satty -f -" }

    [[entries]]
    text = "Toggle Record"
    actions = { "record" = "record" }

    [[entries]]
    text = "OCR"
    keywords = ["ocr", "text recognition", "OCR"]
    actions = { "ocr" = "wayfreeze --hide-cursor --after-freeze-cmd 'grim -g \"$(slurp)\" - | tesseract stdin stdout -l deu+eng | wl-copy; killall wayfreeze'" }

    [[entries]]
    text = "Screenshot Region"
    actions = { "region" = "wayfreeze --hide-cursor --after-freeze-cmd 'IMG=~/Pictures/$(date +%Y-%m-%d_%H-%M-%S).png && grim -g \"$(slurp)\" $IMG && wl-copy < $IMG; killall wayfreeze'" }

    [[entries]]
    text = "Screenshot Window"
    actions = { "window" = "wayfreeze --after-freeze-cmd 'IMG=~/Pictures/$(date +%Y-%m-%d_%H-%M-%S).png && grim $IMG && wl-copy < $IMG; killall wayfreeze'" }

    [[entries]]
    text = "other menu"
    submenu = "other"
  '';

  home.file.".config/elephant/websearch.toml".text = ''
    [[entries]]
    # default = true
    name = "DuckDuckGo"
    url = "https://duckduckgo.com/?q=%TERM%"

    [[entries]]
    # default = true
    name = "Google"
    prefix = "google"
    url = "https://www.google.com/search?q=%TERM%"


    [[entries]]
    name = "Wikipedia"
    prefix = "wiki"
    url = "https://en.wikipedia.org/wiki/Special:Search?search=%TERM%"

    [[entries]]
    name = "YouTube"
    prefix = "yt"
    url = "https://www.youtube.com/results?search_query=%TERM%"

    [[entries]]
    name = "NixPkgs"
    prefix = "nixpkgs"
    url = "https://search.nixos.org/packages?query=%TERM%&channel=unstable"

    [[entries]]
    name = "GitHub"
    prefix = "gh"
    url = "https://github.com/search?q=%TERM%&type=repositories"
  '';
}
