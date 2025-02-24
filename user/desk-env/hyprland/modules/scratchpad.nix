{ lib, config, ... }:

let
  inherit (lib)
    mkOption
    types
    concatStringsSep
    optionalString
    ;

  toToml = sp: ''
    [scratchpads.${sp.name}]
    ${optionalString (sp ? animation) "animation = \"${sp.animation}\""}
    command = "${sp.command}"
    class = "${sp.class}"
    ${optionalString (sp ? size) "size = \"${sp.size}\""}
    ${optionalString (sp ? max_size) "max_size = \"${sp.max_size}\""}
    ${optionalString (sp ? position) "position = \"${sp.position}\""}
    ${optionalString (sp ? multi) "multi = ${if sp.multi then "true" else "false"}"}
    ${optionalString (sp ? margin) "margin = ${toString sp.margin}"}
    ${optionalString (sp ? lazy) "lazy = ${if sp.lazy then "true" else "false"}"}
    ${optionalString (sp ? pinned) "pinned = ${if sp.pinned then "true" else "false"}"}
    ${optionalString (sp ? unfocus) "unfocus = \"${sp.unfocus}\""}
  '';

  # Generate the full TOML config
  pyprlandToml = ''
    [pyprland]
    plugins = ["scratchpads", "magnify"]

    ${concatStringsSep "\n\n" (map toToml config.scratchpads)}
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
            type = types.str;
            example = "ALT,Z";
          };
          command = mkOption {
            type = types.str;
            example = "kitty --class kitty-dropterm";
            description = "This is the command you wish to run in the scratchpad.";
          };
          class = mkOption {
            type = types.str;
            example = "kitty-dropterm";
            description = "Allows Pyprland to prepare the window for a correct animation and initial positioning.";
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
            type = types.str;
            example = "75% 60%";
            description = "Each time the scratchpad is shown, the window will be resized according to the provided values.";
          };
          max_size = mkOption {
            type = types.nullOr types.str;
            default = null;
            example = "1920px 100%";
            description = "Limits the size of the window accordingly. To ensure a window will not be too large on a wide screen, for instance.";
          };
          position = mkOption {
            type = types.nullOr types.str;
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
    home.file.".config/hypr/pyprland.toml".text = pyprlandToml;
    wayland.windowManager.hyprland.settings.bind = map (
      s: "${s.bind},exec,pypr toggle ${s.name} && hyprctl dispatch bringactivetotop"
    ) (builtins.filter (s: lib.hasAttr "bind" s) config.scratchpads);

  };
}
