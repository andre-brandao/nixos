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
    # github-desktop
  ];
  programs = {
    git = {
      enable = true;
      lfs.enable = true; # git config http.postBuffer 524288000
      settings = {
        user.name = userSettings.git-user;
        user.email = userSettings.email;

        alias = {
          ci = "commit";
          co = "checkout";
          s = "status";
        };
        color.ui = true;
        credential.helper = "store";
        github.user = userSettings.git-user;
      };
    };

    # git-credential-oauth = {
    #   enable = true;
    # };
  };
}
