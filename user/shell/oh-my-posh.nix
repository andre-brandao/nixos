{ config, ... }:

{
  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      "$schema" = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";
      "palette" = {
        "rosewater" = "#f5e0dc";
        "Flamingo" = "#f2cdcd";
        "Pink" = "#f5c2e7";
        "Mauve" = "#cba6f7";
        "Red" = "#f38ba8";
        "Maroon" = "#eba0ac";
        "Peach" = "#fab387";
        "Yellow" = "#f9e2af";
        "Green" = "#a6e3a1";
        "Teal" = "#94e2d5";
        "Sky" = "#89dceb";
        "Sapphire" = "#74c7ec";
        "Blue" = "#89b4fa";
        "Lavender" = "#b4befe";
        "Text" = "#cdd6f4";
        "Subtext1" = "#bac2de";
        "Subtext0" = "#a6adc8";
        "Overlay2" = "#9399b2";
        "Overlay1" = "#7f849c";
        "Overlay0" = "#6c7086";
        "Surface2" = "#585b70";
        "Surface1" = "#45475a";
        "Surface0" = "#313244";
        "Base" = "#1e1e2e";
        "Mantle" = "#181825";
        "Crust" = "#11111b";
      };
      "blocks" = [
        {
          "alignment" = "left";
          "segments" = [
            {
              "foreground" = "p:Sapphire";
              "style" = "plain";
              "template" = "┏[<#ffffff></> {{ .UserName }} from <#ffffff></> {{ .HostName }}]";
              "type" = "session";
            }
            {
              "foreground" = "p:Mauve";
              "properties" = {
                "style" = "dallas";
                "threshold" = 0;
              };
              "style" = "diamond";
              "template" = "[<#ffffff></> {{ .FormattedMs }}s]";
              "type" = "executiontime";
            }
            {
              "properties" = {
                "root_icon" = "";
              };
              "style" = "diamond";
              "template" = "";
              "type" = "root";
            }
            {
              "foreground" = "p:Sky";
              "properties" = {
                "time_format" = "2006-01-02 15:04:05";
              };
              "style" = "diamond";
              "template" = "[<#ffffff></> {{ .CurrentDate | date .Format }}]";
              "type" = "time";
            }
            {
              "foreground" = "p:Pink";
              "properties" = {
                "fetch_stash_count" = true;
                "fetch_status" = true;
                "fetch_upstream_icon" = true;
              };
              "style" = "plain";
              "template" = "[<#ffffff>{{ .UpstreamIcon }}</>{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }} <#ffffff></> {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }} <#ffffff></> {{ .Staging.String }}{{ end }}{{ if gt .StashCount 0 }} <#ffffff></> {{ .StashCount }}{{ end }}]";
              "type" = "git";
            }
            {
              "type" = "go";
              "style" = "plain";
              "foreground" = "p:Blue";
              "template" = "[ {{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}]";
            }
            {
              "type" = "rust";
              "style" = "plain";
              "foreground" = "p:Peach";
              "template" = "[ {{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}]";
            }
            {
              "type" = "buf";
              "style" = "plain";
              "template" = "[ {{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}]";
            }
            {
              "type" = "python";
              "style" = "plain";
              "foreground" = "p:Lavender";
              "template" = "[ {{ if .Error }}{{ .Error }}{{ else }}{{ if .Venv }}{{ .Venv }} {{ end }}{{ .Full }}{{ end }}]";
            }
            {
              "foreground" = "p:Pink";
              "style" = "plain";
              "template" = "[{{ .Profile }}{{if .Region}}@{{ .Region }}{{ end }}]";
              "type" = "aws";
            }
            {
              "foreground" = "p:Pink";
              "style" = "plain";
              "template" = "[{{.Context}}{{if .Namespace}} :: {{.Namespace}}{{end}}]";
              "type" = "kubectl";
            }
            {
              "foreground" = "p:Red";
              "style" = "plain";
              "template" = "[]";
              "type" = "root";
            }
            {
              "foreground" = "p:Red";
              "style" = "powerline";
              "template" = "[<#ffffff></> Error, check your command]";
              "type" = "exit";
            }
          ];
          "type" = "prompt";
        }
        {
          "alignment" = "left";
          "newline" = true;
          "segments" = [
            {
              "foreground" = "p:Teal";
              "properties" = {
                "style" = "agnoster_short";
                "folder_icon" = " ";
                "folder_separator_icon" = " 󰥭 ";
                "home_icon" = " ";
                "max_depth" = 3;
                "hide_root_location" = false;
              };
              "style" = "plain";
              "template" = "┖[<#98bfad>{{ .Path }}</>]";
              "type" = "path";
            }
            {
              "type" = "shell";
              "style" = "plain";
              "template" = "[ {{ .Shell }}]";
            }
          ];
          "type" = "prompt";
        }
        {
          "alignment" = "left";
          "newline" = true;
          "segments" = [
            {
              "foreground" = "#7eb8da";
              "style" = "plain";
              "template" = "└─Δ";
              "type" = "text";
            }
          ];
          "type" = "prompt";
        }
      ];
      "final_space" = true;
      "version" = 2;
      "transient_prompt" = {
        "background" = "transparent";
        "foreground" = "p:Sapphire";
        "template" = "└─Δ";
      };
    };
  };
}
