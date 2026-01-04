output "vm_id" {
  description = "The ID of the created VM"
  value       = proxmox_virtual_environment_vm.docker_compose_vm.id
}

output "vm_name" {
  description = "The name of the created VM"
  value       = proxmox_virtual_environment_vm.docker_compose_vm.name
}

output "vm_password" {
  description = "The generated password for the VM user"
  value       = random_password.vm_password.result
  sensitive   = true
}

output "vm_ipv4_addresses" {
  description = "The IPv4 addresses of the VM"
  value       = proxmox_virtual_environment_vm.docker_compose_vm.ipv4_addresses
}

output "vm_mac_addresses" {
  description = "The MAC addresses of the VM"
  value       = proxmox_virtual_environment_vm.docker_compose_vm.mac_addresses
}

output "username" {
  description = "The primary username on the VM"
  value       = "docker"
}
