{
  pkgs,
  ...
}:
{
  programs.chromium={
    enable = true;
    dictionaries = [
      pkgs.hunspellDictsChromium.en_US
      pkgs.hunspellDictsChromium.pt_BR
    ];
    extensions = [

      "nngceckbapebfimnlniiiahkandclblb"  # bitwarden
       # bypass paywall
      "dcpihecpambacapedldabdbpakmachpb;https://cdn.jsdelivr.net/gh/iamadamdev/bypass-paywalls-chrome/src/updates/updates.xml"
  "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
    ];
  };
}