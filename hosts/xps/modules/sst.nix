{

  security.sudo.extraRules = [
    {
      users = [ "andre" ]; # Replace with your username
      commands = [
        {
          command = "/opt/sst/tunnel tunnel start *";
          options = [
            "NOPASSWD"
            "SETENV"
          ];
        }
      ];
    }
  ];

  # --- sst ---
  systemd.tmpfiles.rules = [
    "d /opt/sst 0755 root root -"
  ];

  # system.activationScripts.sstTunnel = ''
  #   mkdir -p /opt/sst
  #   chmod 755 /opt/sst
  # '';
  #  --- sst ---

}
