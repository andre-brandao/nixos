
module "system-build" {
  source              = "github.com/nix-community/nixos-anywhere//terraform/nix-build"
  attribute           = "../../#nixosConfigurations.iso.config.system.build.isoImage"
}


resource "proxmox_virtual_environment_file" "nixos-25_11-iso" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "pve"
  source_file {
    path = "${module.system-build.result.out}/iso/${one(fileset("${module.system-build.result.out}/iso", "*.iso"))}"
  }
}

output "filename" {
  value = proxmox_virtual_environment_file.nixos-25_11-iso.file_name
}

output "iso_id" {
  value = proxmox_virtual_environment_file.nixos-25_11-iso.id
}
