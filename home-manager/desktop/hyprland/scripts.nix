{
  pkgs,

  settings,
  ...
}:
rec {
  # launcher = "caelestia-shell ipc call drawers toggle launcher";

  launcher = ''walker --width 700 --height 600'';

  screenshot = "${pkgs.writeShellScriptBin "screenshot" ''
    ${pkgs.hyprshot}/bin/hyprshot -m region --raw |
      ${pkgs.unstable.satty}/bin/satty --filename - \
        --output-filename "/home/${settings.username}/Pictures/Screenshots/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png" \
        --early-exit \
        --actions-on-enter save-to-clipboard \
        --save-after-copy \
        --copy-command 'wl-copy'
  ''}/bin/screenshot";

  monitor-toggle = "${pkgs.writeShellScriptBin "monitor-toggle" ''
    # Get monitor information as JSON
    monitors_json=$(hyprctl -j monitors all)

    # Find primary monitor (usually eDP-1 for laptops)
    primary=$(echo "$monitors_json" | ${pkgs.jq}/bin/jq -r '.[] | select(.name | startswith("eDP")) | .name')

    # Find secondary monitor (not primary and not disabled)
    secondary=$(echo "$monitors_json" | ${pkgs.jq}/bin/jq -r '.[] | select(.name != "'$primary'" and .disabled == false) | .name' | head -n1)

    if [ -z "$primary" ]; then
        echo "No primary monitor found"
        ${pkgs.libnotify}/bin/notify-send "Monitor Toggle" "No primary monitor found" -i display
        exit 1
    fi

    if [ -z "$secondary" ]; then
        echo "No secondary monitor detected"
        ${pkgs.libnotify}/bin/notify-send "Monitor Toggle" "No secondary monitor detected" -i display
        exit 1
    fi

    # Check if secondary monitor is currently mirroring
    mirror_status=$(echo "$monitors_json" | ${pkgs.jq}/bin/jq -r '.[] | select(.name == "'$secondary'") | .mirrorOf')

    if [ "$mirror_status" != "none" ]; then
        # Currently mirrored, switch to extended
        echo "Switching $secondary from mirror to extended mode"
        hyprctl keyword monitor "$secondary,preferred,auto,1"
        ${pkgs.libnotify}/bin/notify-send "Monitor Toggle" "Switched to Extended Mode\n$secondary is now extending the desktop" -i display
    else
        # Currently extended, switch to mirror
        echo "Switching $secondary from extended to mirror mode"
        hyprctl keyword monitor "$secondary,preferred,0x0,1,mirror,$primary"
        ${pkgs.libnotify}/bin/notify-send "Monitor Toggle" "Switched to Mirror Mode\n$secondary is now mirroring $primary" -i display
    fi

    # Show current status
    echo "Primary: $primary"
    echo "Secondary: $secondary"
    echo "Mirror status: $mirror_status"
  ''}/bin/monitor-toggle";

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
