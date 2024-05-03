# My NixOS

![Desktop](https://github.com/andre-brandao/nixos/blob/main/themes/.images/ashes.png?raw=true)

![Desktop](https://github.com/andre-brandao/nixos/blob/main/themes/.images/stella.png?raw=true)

![Desktop](https://github.com/andre-brandao/nixos/blob/main/themes/.images/emil.png?raw=true)

![Desktop](https://github.com/andre-brandao/nixos/blob/main/themes/.images/fairy-floss.png?raw=true)

![Desktop](https://github.com/andre-brandao/nixos/blob/main/themes/.images/gigavolt.png?raw=true)

## Basic Flake Comands

### To rebuild home-manager, use the following command in the config directory:

```bash
home-manager switch --flake .#user
```

or the alias from anywhere:

```bash
sys-update
```

### To rebuild the system, use the following command in the config directory:

```bash
sudo nixos-rebuild switch --flake .#system
```

or the alias from anywhere:

```bash
user-update
```

### Available Desktop Enviroments

- Hyprland (current)
- GNOME
- QTile (just a simple config, no stylix)

### Stylix

A nix flake that aplies a BASE16 colorscheme across multiple apps and desktop enviroments


Check my stylix config at /user/style and /system/style or https://danth.github.io/stylix/index.html for all options

Check out the themes directory!!

## File Strucure

```bash
profiles
|  personal
|  |  hardware-configurantion.nix # CHANGE THIS!!
system
|  app # System aplications
|  config # Common system configs
|  style # Stylix settings
|  desk-env # GNOME and hyprland
user
|  app  # User aplications
|  |  editor # nvim and helix
|  |  git
|  |  terminal # kitty and alacritty
|  shell # Shell config (tmux + zsh + cli tools)
|  lang # Programing languages
|  desk-env # IN PROGRESS
themes # Base16 colors
flake.nix
```

### dotfiles that helped

[Misterio77's nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)

[librephoenix's nixos-config](https://github.com/librephoenix/nixos-config)
