{
  config,
  pkgs,
  settings,
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
        user.name = settings.git.user;
        user.email = settings.git.email;

        alias = {
          ci = "commit";
          co = "checkout";
          s = "status";
        };
        color.ui = true;
        credential.helper = "store";
        github.user = settings.git.user;
      };
    };

    # git-credential-oauth = {
    #   enable = true;
    # };
  };
}
