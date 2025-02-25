{ lib, config, ... }:

let
  inherit (lib)
    mkOption
    types
    concatStringsSep
    optionalString
    ;

  f = key: value: if value != null then "${key} = ${toString value}" else "";
  fs = key: value: if value != null then ''${key} = "${toString value}"'' else "";

  toToml = sp: ''
    [scratchpads.${sp.name}]
    ${fs "animation" sp.animation}
    ${fs "command" sp.command}
    ${fs "class" sp.class}
    ${fs "match_by" sp.match_by}
    ${fs "initialClass" sp.initialClass}
    ${fs "initialTitle" sp.initialTitle}
    ${fs "title" sp.title}
    ${fs "size" sp.size}
    ${fs "max_size" sp.max_size}
    ${fs "position" sp.position}
    ${f "multi" sp.multi}
    ${f "margin" sp.margin}
    ${f "lazy" sp.lazy}
    ${f "pinned" sp.pinned}
    ${fs "unfocus" sp.unfocus}
  '';
in
{
  options.scratchpads = mkOption {
    type = types.listOf (
      types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            example = "term";
          };
          bind = mkOption {
            type = types.nullOr types.str;
            example = "ALT,Z";
            default = null;
            description = "The keybinding to toggle the scratchpad.";
          };
          command = mkOption {
            type = types.str;
            example = "kitty --class kitty-dropterm";
            description = "This is the command you wish to run in the scratchpad.";
          };
          class = mkOption {
            type = types.nullOr types.str;
            example = "kitty-dropterm";
            default = null;
            description = "Allows Pyprland to prepare the window for a correct animation and initial positioning.";
          };
          match_by = mkOption {
            type = types.nullOr (
              types.enum [
                "class"
                "initialClass"
                "title"
                "initialTitle"
              ]
            );
            default = null;
            description = "will match the client window using the provided property instead of the PID of the process";
          };
          initialClass = mkOption {
            type = types.nullOr types.str;
            default = null;
            example = "kitty";
            description = "The initial class of the client window.";
          };
          initialTitle = mkOption {
            type = types.nullOr types.str;
            default = null;
            example = "kitty";
            description = "The initial title of the client window.";
          };
          title = mkOption {
            type = types.nullOr types.str;
            default = null;
            example = "kitty";
            description = "The title of the client window.";
          };
          animation = mkOption {
            type = types.nullOr (
              types.enum [
                "fromBottom"
                "fromTop"
                "fromLeft"
                "fromRight"
              ]
            );
            default = null;
            example = "fromBottom";
            description = "Type of animation to use, default value is fromTop.";
          };
          size = mkOption {
            type = types.strMatching "[0-9]+% [0-9]+%";
            example = "75% 60%";
            description = "Each time the scratchpad is shown, the window will be resized according to the provided values.";
          };
          max_size = mkOption {
            type = types.nullOr (types.strMatching "[0-9]+(px|%) [0-9]+(px|%)");
            default = null;
            example = "1920px 100%";
            description = "Limits the size of the window accordingly. To ensure a window will not be too large on a wide screen, for instance.";
          };
          position = mkOption {
            type = types.nullOr (types.strMatching "[0-9]+% [0-9]+%");
            default = null;
            example = "50% 0%";
            description = "Sets the scratchpad client window position relative to the top-left corner.";
          };
          multi = mkOption {
            type = types.nullOr types.bool;
            default = null;
            description = "When set to false, only one client window is supported for this scratchpad. Otherwise, other matching windows will be attached to the scratchpad.";
          };
          margin = mkOption {
            type = types.nullOr types.int;
            default = null;
            example = 50;
          };
          lazy = mkOption {
            type = types.nullOr types.bool;
            default = null;
            example = true;
            description = "When set to true, prevents the command from being started when Pypr starts. It will be started when the scratchpad is first used instead.";
          };
          pinned = mkOption {
            type = types.nullOr types.bool;
            default = null;
            example = true;
            description = "Makes the scratchpad sticky to the monitor, following any workspace change.";
          };
          unfocus = mkOption {
            type = types.nullOr (types.enum [ "hide" ]);
            default = null;
            example = "hide";
            description = "When set to 'hide', allows hiding the window when focus is lost.";
          };
        };
      }
    );
    default = [ ];
  };

  config = {
    home.file.".config/hypr/pyprland.toml".text = ''
      [pyprland]
      plugins = ["scratchpads", "magnify"]

      ${concatStringsSep "\n\n" (map toToml config.scratchpads)}
    '';
    wayland.windowManager.hyprland.settings.bind = map (
      s: "${s.bind},exec,pypr toggle ${s.name} && hyprctl dispatch bringactivetotop"
    ) (builtins.filter (s: s.bind != null) config.scratchpads);

  };
}
