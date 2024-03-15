{pkgs, ...}: {
  home.packages = with pkgs; [
    nodejs
    supabase-cli
    turso-cli
  ];
}
