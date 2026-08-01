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
        credential = {
          helper = "store";
          # Buzz relay git (NIP-98 auth). Scoped to the relay host so the
          # global `store` helper keeps handling GitHub et al.
          #   - "" resets the inherited helper list, so `store` is not
          #     consulted first for this host.
          #   - useHttpPath is required: NIP-98 signs the exact request URL,
          #     so the helper must see the full path to produce a token the
          #     relay will verify.
          "https://buzz.developing.company" = {
            helper = [
              ""
              "${pkgs.buzz}/bin/git-credential-nostr"
            ];
            useHttpPath = true;
          };
        };
        # Read by git-credential-nostr when $NOSTR_PRIVATE_KEY is unset.
        # The file must be mode 0600 or the helper refuses to run.
        nostr.keyfile = "${config.home.homeDirectory}/.nostr/key";
        github.user = settings.git.user;
      };
    };

    # git-credential-oauth = {
    #   enable = true;
    # };
  };
}
