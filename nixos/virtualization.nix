
{pkgs, ...}:

{
  virtualisation.libvirtd = {
  enable = true;
  qemu = {
    package = pkgs.qemu_kvm;
    runAsRoot = true;
    swtpm.enable = true;
    ovmf = {
      enable = true;
      packages = [(pkgs.unstable.OVMF.override {
        secureBoot = true;
        tpmSupport = true;
      }).fd];
    };
  };
  };
  programs.virt-manager.enable = true;
  dconf.settings = {
  "org/virt-manager/virt-manager/connections" = {
    autoconnect = ["qemu:///system"];
    uris = ["qemu:///system"];
    };
  };

}