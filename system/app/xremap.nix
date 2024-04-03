{ userSettings, ... }: {
  hardware.uinput.enable = true;
  users.groups.uinput.members = [ userSettings.username ];
  users.groups.input.members = [ userSettings.username ];
}
