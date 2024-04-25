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
      userName = "andre-brandao";
      userEmail = "brandaoandre00@gmail.com";

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
