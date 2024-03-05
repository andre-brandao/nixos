
{pkgs, ...}:

{
  ## DOCKER
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };

  }; 
  environment.systemPackages = with pkgs; [
    lazydocker
  ];

  ## QEMU + VirtManager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
}