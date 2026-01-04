variable "vm_id" {
  type = number
  default     = null
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "vm_description" {
  description = "Description of the virtual machine"
  type        = string
  default     = "Managed by Terraform - Docker Compose VM"
}

variable "vm_tags" {
  description = "Tags to apply to the virtual machine"
  type        = list(string)
  default     = ["terraform", "ubuntu", "docker"]
}

variable "node_name" {
  description = "Proxmox node name"
  type        = string
  default     = "pve"
}

variable "datastore_id" {
  description = "Datastore ID for VM disks"
  type        = string
  default     = "local-zfs"
}

variable "cpu_cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 2
}
variable "cpu_sockets" {
  description = "Number of CPU sockets"
  type = number
  default = 1
}

variable "memory_mb" {
  description = "Memory in MB"
  type        = number
  default     = 4096
}

variable "disk_size_gb" {
  description = "Disk size in GB"
  type        = number
  default     = 20
}

variable "ip_address" {
  description = "IP address configuration (e.g., 'dhcp' or '192.168.1.100/24')"
  type        = string
  default     = "dhcp"
}

variable "network_bridge" {
  description = "Network bridge to use"
  type        = string
  default     = "vmbr0"
}

variable "ubuntu_image_url" {
  description = "URL to Ubuntu cloud image"
  type        = string
  default     = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
}

variable "ubuntu_image_filename" {
  description = "Filename for the Ubuntu cloud image"
  type        = string
  default     = "noble-server-cloudimg-amd64.qcow2"
}

variable "cloud_image_id" {
  description = "ID of an existing cloud image to use instead of downloading a new one. If null, a new image will be downloaded."
  type        = string
  default     = null
}

variable "hostname" {
  description = "Hostname for the VM"
  type        = string
}

variable "timezone" {
  description = "Timezone for the VM"
  type        = string
  default     = "America/Sao_Paulo"
}



variable "ssh_keys" {
  description = "List of SSH public keys to add to the user"
  type        = list(string)
}

variable "additional_packages" {
  description = "Additional packages to install via apt"
  type        = list(string)
  default     = []
}
