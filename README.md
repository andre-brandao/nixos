# My NixOS

### My nixos journey

I installed NixOS on my laptop because I was intrigued by its concept and wanted to give it a try. I initially started with a minimal starter configuration from [Misterio77's nix-starter-configs](https://github.com/Misterio77/nix-starter-configs). However, I later transitioned to a structure based on [librephoenix's nixos-config](https://github.com/librephoenix/nixos-config).


## Basic Flake Comands

### To rebuild home-manager, use the following command in the config directory:
```bash
home-manager swith --flake .#user
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




## File Strucure
```bash
profiles
|  personal
system
|  app # System aplications
|  config # Common system configs 
|  style # Stylix settings
|  desk-env # GNOME and hyprland
|  hardware-configurantion.nix # CHANGE THIS!!
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
