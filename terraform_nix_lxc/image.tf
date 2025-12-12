resource "proxmox_virtual_environment_file" "nixos" {
  content_type = "vztmpl"
  datastore_id = "local"
  node_name    = "pve"

  source_file {
    path = "./result/tarball/nixos-image-lxc-proxmox-25.11.20251206.d9bc5c7-x86_64-linux.tar.xz"
  }
}
