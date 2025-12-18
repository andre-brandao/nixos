resource "proxmox_virtual_environment_vm" "docker_vm" {
  name        = var.vm_name
  description = var.vm_description
  tags        = var.vm_tags
  node_name   = var.node_name
  bios        = "ovmf"

  efi_disk {
    datastore_id      = var.datastore_id
    pre_enrolled_keys = false
  }

  agent {
    enabled = true
  }

  cpu {
    cores = var.cpu_cores
    type  = "host"
  }

  memory {
    dedicated = var.memory_mb
  }

  disk {
    datastore_id = var.datastore_id
    import_from  = var.cloud_image_id != null ? var.cloud_image_id : proxmox_virtual_environment_download_file.ubuntu_cloud_image[0].id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = var.disk_size_gb
  }

  initialization {
    datastore_id = var.datastore_id
    interface    = "scsi1"

    ip_config {
      ipv4 {
        address = var.ip_address
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
  }

  network_device {
    bridge = var.network_bridge
  }
}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  count = var.cloud_image_id == null ? 1 : 0

  content_type = "import"
  datastore_id = "local"
  node_name    = var.node_name
  url          = var.ubuntu_image_url
  file_name    = var.ubuntu_image_filename

  lifecycle {
    ignore_changes = [file_name, url]
  }
}

resource "random_password" "vm_password" {
  length           = 16
  override_special = "_%@"
  special          = true
}

resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.node_name

  source_raw {
    data = templatefile("${path.module}/templates/cloud-init.tftpl", {
      hostname               = var.hostname
      timezone               = var.timezone
      ssh_keys               = var.ssh_keys
      service_name           = var.service_name
      additional_packages    = var.additional_packages
    })

    file_name = "${var.vm_name}-cloud-config.yaml"
  }
}
