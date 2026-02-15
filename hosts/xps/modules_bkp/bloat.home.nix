{ pkgs, ... }:
{

  home.packages =
    (with pkgs; [
      netflix
      filezilla
      teams-for-linux

      # playwright
      playwright-test
      playwright-driver.browsers

      movit
      mediainfo
      libmediainfo
      mediainfo-gui
      mpv
      gimp
      inkscape
      beekeeper-studio

      # dbeaver-bin
      # schemacrawler
      aircrack-ng
      netcat
      # metasploit
      mediawriter

      # warp-terminal
      qgis
      # rpi-imager
      # rars
      # jflap
      android-studio
      # ciscoPacketTracer8
      # jetbrains.pycharm-professional
      #
      # protonmail-bridge-gui
      # protonmail-desktop
      # discord-screenaudio
      # brave
      # firefox
      #
      #
      # waveterm
      #       claude-code
    ])
    ++ (with pkgs.unstable; [
      # zed-editor
      # jetbrains.webstorm
      jetbrains-toolbox
      supabase-cli
      turso-cli
      stripe-cli
      graphite-cli
      nodePackages_latest.vercel
      waveterm

      # railway
      #
      # lens
      #
      # kubernetes-helm
      # kustomize
      # vault
      #       supabase-cli

    ]);
}
