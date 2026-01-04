resource "proxmox_virtual_environment_vm" "nixos_vm" {
  name        = "mine-server"
  tags        = ["terraform", "nixos", "minecraft"]
  node_name   = "pve"
  description = "NixOS VM"
  # bios = "ovmf"
  # machine = "q35"
  boot_order = ["scsi0", "ide2"]

  agent {
    enabled = true
  }

  cpu {
    cores   = 8
    sockets = 2
    type    = "host"
  }

  memory {
    floating  = 1024 * 16
    dedicated = 1024 * 16
  }

  operating_system {
    type = "l26"
  }

  disk {
    datastore_id = "local-zfs"
    file_format  = "raw"
    interface    = "scsi0"
    size         = 80
  }

  cdrom {
    file_id = "local:iso/nixos-minimal-25.11.20251209.09eb77e-x86_64-linux.iso"
    interface    = "ide2"
  }

  network_device {
    bridge = "vmbr0"
  }


  on_boot = true
}


module "system-build" {
  source = "github.com/nix-community/nixos-anywhere//terraform/nix-build"
  # with flakes
  attribute = "../../../../#nixosConfigurations.pve-mine.config.system.build.toplevel"
  # without flakes
  # file can use (pkgs.nixos []) function from nixpkgs
  #file                = "${path.module}/../.."
  #attribute           = "config.system.build.toplevel"
}


module "disko" {
  source = "github.com/nix-community/nixos-anywhere//terraform/nix-build"
  # with flakes
  attribute = "../../../../#nixosConfigurations.pve-mine.config.system.build.diskoScript"
  # without flakes
  # file can use (pkgs.nixos []) function from nixpkgs
  #file           = "${path.module}/../.."
  #attribute      = "config.system.build.diskoScript"
}

locals {
  use_tailnet = true
  target_host = local.use_tailnet ? "mine" : proxmox_virtual_environment_vm.nixos_vm.ipv4_addresses[1][0]
}



module "install" {
  source            = "github.com/nix-community/nixos-anywhere//terraform/install"
  nixos_system      = module.system-build.result.out
  nixos_partitioner = module.disko.result.out
  # target_host       = local.ipv4
  target_host = local.target_host
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
  target_host        = local.target_host
  target_user        = "andre"
}

output "machine_ip" {
  value = proxmox_virtual_environment_vm.nixos_vm.ipv4_addresses[1][0]
}
