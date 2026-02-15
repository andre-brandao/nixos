{
  # ---- deep sleep ----
  boot.kernelParams = [
    "resume_offset=14204928"
    "mem_sleep_default=deep"
  ];

  boot.resumeDevice = "/dev/disk/by-uuid/4b1ea965-befe-439d-9e3d-d84bdc35bae0";

  powerManagement.enable = true;
  services.power-profiles-daemon.enable = true;
  # Suspend first then hibernate when closing the lid
  services.logind.settings.Login.HandleLidSwitch = "suspend-then-hibernate";
  # Hibernate on power button pressed
  services.logind.settings.Login.HandlePowerKey = "hibernate";
  services.logind.settings.Login.HandlePowerKeyLongPress = "poweroff";
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30m
    SuspendState=mem
  '';

  # ---- deep sleep ----

}
