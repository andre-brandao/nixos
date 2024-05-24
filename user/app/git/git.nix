{
  config,
  pkgs,
  userSettings,
  ...
}:
{
  home.packages = with pkgs; [
    git
    gh
    lazygit
    github-desktop
  ];
  programs = {
    git = {
      enable = true;
      lfs.enable = true; # git config http.postBuffer 524288000
      userName = userSettings.git-user;
      userEmail = userSettings.email;

      aliases = {
        ci = "commit";
        co = "checkout";
        s = "status";
      };
      # extraConfig = {
      #   credential.helper = "${pkgs.git.override { withLibsecret = true; }}/bin/git-credential-libsecret";
      #   # push = { autoSetupRemote = true; };
      # };
    };

    git-credential-oauth = {
      enable = true;
    };
  };
}
