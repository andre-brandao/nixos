{ pkgs, pkgs-unstable, ... }:
rec {
  caelestia-shell = "nix develop ~/.config/quickshell/shell --command qs -c shell";

  launcher = "${caelestia-shell} ipc call drawers toggle launcher";

  screenshot = "${pkgs.writeShellScriptBin "screenshot" ''
    ${pkgs.hyprshot}/bin/hyprshot -m region --raw |
      ${pkgs-unstable.satty}/bin/satty --filename - \
        --output-filename "~/Pictures/Screenshots/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png" \
        --early-exit \
        --actions-on-enter save-to-clipboard \
        --save-after-copy \
        --copy-command 'wl-copy'
  ''}/bin/screenshot";

  update-checker = "${(pkgs.writeShellScriptBin "update-checker" ''
    #Check the current time, this should only run between 10pm  and 6am
    hour=$(date +%H)
    if [ $hour -ge 22 ] || [ $hour -lt 6 ]; then
        exit 0
    fi

    #This script assumes your flake is in ~/.dotfiles and that your flake's nixosConfigurations is named the same as your $hostname
     updates="$(cd ~/dotfiles/nixos && nix flake update nixpkgs && nix build .#nixosConfigurations.system.config.system.build.toplevel --option max-jobs 2 && ${pkgs.nvd}/bin/nvd diff /run/current-system ./result | grep -e '\[U' | wc -l)"

     alt="has-updates"
     if [ $updates -eq 0 ]; then
         alt="updated"
     fi

     tooltip="System updated"
     if [ $updates != 0 ]; then
    	    tooltip=$(cd ~/dotfiles/nixos && ${pkgs.nvd}/bin/nvd diff /run/current-system ./result | grep -e '\[U' | ${pkgs.gawk}/bin/awk '{ for (i=3; i<NF; i++) printf $i " "; if (NF >= 3) print $NF; }' ORS='\\n' )
     fi

     echo "{ \"text\":\"$updates\", \"alt\":\"$alt\", \"tooltip\":\"$tooltip\" }"
  '')}/bin/update-checker";
}
