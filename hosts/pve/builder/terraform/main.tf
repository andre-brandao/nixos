locals {
  # use_tailnet = false
  # target_host = local.use_tailnet ? "builder" : proxmox_virtual_environment_vm.nixos_vm.ipv4_addresses[1][0]
  target_host =  proxmox_virtual_environment_vm.nixos_vm.ipv4_addresses[1][0]

}

resource "proxmox_virtual_environment_vm" "nixos_vm" {
  name        = "builder"
  tags        = ["terraform", "nixos", "builder"]
  node_name   = "pve"
  description = "NixOS ARM cross-compilation build machine"
  boot_order  = ["scsi0", "ide2"]

  agent {
    enabled = true
  }

  cpu {
    cores   = 8
    sockets = 1
    type    = "host"
  }

  memory {
    dedicated = 1024 * 16
  }

  operating_system {
    type = "l26"
  }

  disk {
    datastore_id = "local-zfs"
    file_format  = "raw"
    interface    = "scsi0"
    size         = 100
  }

  cdrom {
    file_id   = "local:iso/nixos-minimal-25.11.20251209.09eb77e-x86_64-linux.iso"
    interface = "ide2"
  }

  network_device {
    bridge = "vmbr0"
  }

  on_boot = true
}


module "system-build" {
  source    = "github.com/nix-community/nixos-anywhere//terraform/nix-build"
  attribute = "../../../../#nixosConfigurations.pve-builder.config.system.build.toplevel"
}


module "disko" {
  source    = "github.com/nix-community/nixos-anywhere//terraform/nix-build"
  attribute = "../../../../#nixosConfigurations.pve-builder.config.system.build.diskoScript"
}


module "install" {
  source            = "github.com/nix-community/nixos-anywhere//terraform/install"
  nixos_system      = module.system-build.result.out
  nixos_partitioner = module.disko.result.out
  target_host       = local.target_host
  target_user       = "andre"
}


module "nixos-rebuild" {
  depends_on = [
    module.install
  ]
  source       = "github.com/nix-community/nixos-anywhere//terraform/nixos-rebuild"
  nixos_system = module.system-build.result.out
  target_host  = local.target_host
  target_user  = "andre"
}

output "machine_ip" {
  value = proxmox_virtual_environment_vm.nixos_vm.ipv4_addresses[1][0]
}
