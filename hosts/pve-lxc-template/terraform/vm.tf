resource "proxmox_virtual_environment_container" "nixos_container" {
  description = "nixos"

  node_name = "pve"
  vm_id     = null # Will use next available ID from Proxmox

  operating_system {
    type             = "nixos"
    template_file_id = proxmox_virtual_environment_file.nixos.id
  }

  cpu {
    # architecture = "amd64"
    cores = 4 # Default, adjust as needed
  }

  memory {
    dedicated = 8192 # 8GB RAM
  }

  disk {
    datastore_id = "local-zfs"
    size         = 80 # 80GB disk
  }

  network_interface {
    name     = "eth0"
    bridge   = "vmbr0"
    enabled  = true
    firewall = true
  }

  initialization {
    hostname = "nixos"
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

  }

  console {
    enabled = true
    type    = "console"
  }

  features {
    nesting = true
  }
  wait_for_ip {
    ipv4 = true
  }

  started      = true
  unprivileged = true

  tags = ["terraform", "nixos", "lxc"]
}


# module "system-build" {
#   source              = "github.com/nix-community/nixos-anywhere//terraform/nix-build"
#   # with flakes
#   attribute           = "..#nixosConfigurations.vault.config.system.build.toplevel"
#   # without flakes
#   # file can use (pkgs.nixos []) function from nixpkgs
#   #file                = "${path.module}/../.."
#   #attribute           = "config.system.build.toplevel"
# }

# module "deploy" {
#   # count = proxmox_virtual_environment_container.nixos_container.ipv4 ? 1 : 0
#   source       = "github.com/nix-community/nixos-anywhere//terraform/nixos-rebuild"
#   nixos_system = module.system-build.result.out
#   # target_host  = proxmox_virtual_environment_container.nixos_container.ipv4
#   target_host  = "192.168.0.17"

# }
output "nixos_ip" {
  value = proxmox_virtual_environment_container.nixos_container.ipv4
}
