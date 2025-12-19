resource "proxmox_virtual_environment_vm" "nixos_vm" {
  name        = var.name
  tags        = var.tags
  node_name   = var.pve_node
  description = var.description
  boot_order = ["scsi0", "ide2"]

  agent {
    enabled = true
  }

  cpu {
    cores   = var.cpu_cores
    sockets = var.cpu_sockets
    type    = "host"
  }

  memory {
    dedicated = var.dedicated_memory
  }

  operating_system {
    type = "l26"
  }

  disk {
    datastore_id = var.disk_datastore_id
    file_format  = "raw"
    interface    = "scsi0"
    size         = var.disk_size
  }

  cdrom {
    file_id = var.nixos_iso_id
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
  target_user       = var.admin_user
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
  target_user        = var.admin_user
}

output "machine_ip" {
  value = proxmox_virtual_environment_vm.nixos_vm.ipv4_addresses[1][0]
}
