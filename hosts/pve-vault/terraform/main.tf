# resource "proxmox_virtual_environment_vm" "nixos_vm" {
#   name        = "nixos-vm"
#   node_name   = "pve"
#   description = "NixOS VM"
#   bios = "ovmf"
#   machine = "q35"

#   clone {
#     vm_id = 6000
#     full = true
#     # datastore_id = "shared-vms:backup/vzdump-qemu-nixos-25.11.20251209.09eb77e.vma.zst"
#   }

#   agent {
#     enabled = true
#   }

#   cpu {
#     cores = 2
#   }

#   memory {
#     dedicated = 1024 * 4
#   }

#   efi_disk {
#     datastore_id = "local-zfs"
#     type         = "4m"
#   }

#   disk {
#     datastore_id = "local-zfs"
#     file_format  = "raw"
#     interface    = "scsi0"
#     size         = 32
#   }

#   network_device {
#     bridge = "vmbr0"
#   }

#   operating_system {
#     type = "l26"
#   }
#   virtiofs {
#     mapping = "nix"
#     cache = "always"
#     direct_io = true
#   }

#   on_boot = true
# }


module "system-build" {
  source              = "github.com/nix-community/nixos-anywhere//terraform/nix-build"
  # with flakes
  attribute           = "../../#nixosConfigurations.pve-vault.config.system.build.toplevel"
  # without flakes
  # file can use (pkgs.nixos []) function from nixpkgs
  #file                = "${path.module}/../.."
  #attribute           = "config.system.build.toplevel"
}

module "deploy" {
  # count = proxmox_virtual_environment_container.nixos_container.ipv4 ? 1 : 0
  source       = "github.com/nix-community/nixos-anywhere//terraform/nixos-rebuild"
  nixos_system = module.system-build.result.out
  target_host  = "192.168.0.228"
    # target_host  =  proxmox_virtual_environment_vm.nixos_vm.ipv4_addresses[1][0]
  target_user= "andre"
  install_bootloader = false
}

# output "machine_ip" {
#   value = proxmox_virtual_environment_vm.nixos_vm.ipv4_addresses[1][0]
# }
