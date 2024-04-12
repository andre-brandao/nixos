{
  config,
  pkgs,
  userSettings,
  ...
}:
{
  home.packages = [
    pkgs.git
    pkgs.lazygit
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
    };

    git-credential-oauth = {
      enable = true;
    };
  };
  
}
