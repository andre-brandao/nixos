resource "proxmox_virtual_environment_vm" "nixos_vm" {
  name        = "git-server"
  tags        = ["terraform", "nixos", "git"]
  node_name   = "pve"
  description = "NixOS VM"
  # bios = "ovmf"
  # machine = "q35"
  boot_order = ["scsi0", "ide2"]

  agent {
    enabled = true
  }

  cpu {
    cores   = 2
    sockets = 1
    type    = "host"
  }

  memory {
    dedicated = 1024 * 4
  }

  operating_system {
    type = "l26"
  }


  # efi_disk {
  #   datastore_id = "local-zfs"
  #   type         = "4m"
  # }

  disk {
    datastore_id = "local-zfs"
    file_format  = "raw"
    interface    = "scsi0"
    size         = 50
  }

  cdrom {
    file_id = "local:iso/nixos-minimal-25.11.20251209.09eb77e-x86_64-linux.iso"
    interface    = "ide2"
  }

  network_device {
    bridge = "vmbr0"
  }

  #   operating_system {
  #     type = "l26"
  #   }
  #   virtiofs {
  #     mapping = "nix"
  #     cache = "always"
  #     direct_io = true
  #   }

  on_boot = true
}


module "system-build" {
  source = "github.com/nix-community/nixos-anywhere//terraform/nix-build"
  # with flakes
  attribute = "../../#nixosConfigurations.pve-git.config.system.build.toplevel"
  # without flakes
  # file can use (pkgs.nixos []) function from nixpkgs
  #file                = "${path.module}/../.."
  #attribute           = "config.system.build.toplevel"
}


module "disko" {
  source = "github.com/nix-community/nixos-anywhere//terraform/nix-build"
  # with flakes
  attribute = "../../#nixosConfigurations.pve-git.config.system.build.diskoScript"
  # without flakes
  # file can use (pkgs.nixos []) function from nixpkgs
  #file           = "${path.module}/../.."
  #attribute      = "config.system.build.diskoScript"
}


module "install" {
  source            = "github.com/nix-community/nixos-anywhere//terraform/install"
  nixos_system      = module.system-build.result.out
  nixos_partitioner = module.disko.result.out
  # target_host       = local.ipv4
  target_host = proxmox_virtual_environment_vm.nixos_vm.ipv4_addresses[1][0]
  target_user       = "andre"
}


module "nixos-rebuild" {
  depends_on = [
    module.install
  ]
  # count = proxmox_virtual_environment_container.nixos_container.ipv4 ? 1 : 0
  source       = "github.com/nix-community/nixos-anywhere//terraform/nixos-rebuild"
  nixos_system = module.system-build.result.out
  # target_host  = "192.168.0.228"
  target_host        = proxmox_virtual_environment_vm.nixos_vm.ipv4_addresses[1][0]
  target_user        = "andre"
}

output "machine_ip" {
  value = proxmox_virtual_environment_vm.nixos_vm.ipv4_addresses[1][0]
}
