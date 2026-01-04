variable "name" {
  type = string
  default = "nixos"
}

variable "tags" {
  type = list(string)
  default = ["terraform", "nixos"]
}

variable "pve_node" {
  type = string
  default = "pve"
}

variable "description" {
  type = string
  default = "NixOS VM"
}

variable "cpu_cores" {
  type = number
  default = 4
}

variable "cpu_sockets" {
  type = number
  default = 1
}

variable "dedicated_memory" {
  type = number
  default = 4 * 1024
}

variable "disk_size" {
  type = number
  default = 50
}

variable "disk_datastore_id" {
  type = string
  default = "local-zfs"
}

variable "nixos_iso_id" {
  type = string
  default = "local:iso/nixos-minimal-25.11.20251209.09eb77e-x86_64-linux.iso"
}

variable "admin_user" {
  type = string
  default = "andre"
}
