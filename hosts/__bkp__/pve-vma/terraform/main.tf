
module "system-build" {
  source              = "github.com/nix-community/nixos-anywhere//terraform/nix-build"
  attribute           = "../../#packages.x86_64-linux.proxmox-vma-template"
}


resource "proxmox_virtual_environment_file" "nixos-25_11-vma" {
  content_type = "backup"
  datastore_id = "shared-vms"
  node_name    = "pve"
  source_file {
    path = "${module.system-build.result.out}/${one(fileset("${module.system-build.result.out}", "*.vma*"))}"
  }
}

output "filename" {
  value = proxmox_virtual_environment_file.nixos-25_11-vma.file_name
}

output "vma_id" {
  value = proxmox_virtual_environment_file.nixos-25_11-vma.id
}
