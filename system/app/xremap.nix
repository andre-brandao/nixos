{ pkgs, userSettings, ... }:
{
  hardware.uinput.enable = true;
  users.groups.uinput.members = [ userSettings.username ];
  users.groups.input.members = [ userSettings.username ];
  services.udev = {
    # NOTE: Xremap requires the following:
    # https://github.com/xremap/xremap?tab=readme-ov-file#running-xremap-without-sudo
    extraRules = ''
      KERNEL=="uinput", GROUP="input", MODE="0660", TAG+="uaccess"
    '';
  };
}
