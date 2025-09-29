{ pkgs, pkgs-unstable, ... }:
rec {
  caelestia-shell = "nix develop ~/.config/quickshell/shell --command qs -c shell";

  launcher = "${caelestia-shell} ipc call drawers toggle launcher";

  screenshot_script = "${pkgs.writeShellScriptBin "screenshot" ''
    ${pkgs.hyprshot}/bin/hyprshot -m region --raw |
      ${pkgs-unstable.satty}/bin/satty --filename - \
        --output-filename "~/Pictures/Screenshots/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png" \
        --early-exit \
        --actions-on-enter save-to-clipboard \
        --save-after-copy \
        --copy-command 'wl-copy'
  ''}/bin/screenshot";
}
