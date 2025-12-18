resource "proxmox_vm_qemu" "cloudinit-example" {
  vmid             = var.vm_id
  name             = "redes-vm"
  target_node      = "pve"
  agent            = 1
  memory           = 4096
  balloon          = 0
  bios             = "ovmf"
  machine          = "q35"
  boot             = "order=virtio0"
  clone            = "ubuntu-24-04-template"
  scsihw           = "virtio-scsi-pci"
  vm_state         = "running"
  automatic_reboot = true
  tags             = "ubuntu-template,noble,cloudinit"

  # Cloud-Init configuration
  cicustom   = "vendor=local:snippets/ubuntu.yaml"
  ciupgrade  = true
  nameserver = "1.1.1.1 8.8.8.8"
  ipconfig0  = "ip=dhcp"
  skip_ipv6  = true
  ciuser     = "naisses"
  cipassword = "senha123"
  sshkeys    = <<EOT
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCuQkJ02xZKVFiulDUVgtyOzR01L9aj0ydfivlJtuip81NqsfPhwWW4XyW6uLkkhmOsDUsr9ZhEzl4XsLRX2r8PZS03/XBLH/7Yft6P01ECxyCe9vnXZ8i8J3FJ141ZLQPXtNTqpRmPdPYbclDQASqnVu5UKfaBlWyheXni9R0bvPC1FqpozUh4+UVUMJT4dUkThSX+Ph5/czJAZkwzwsKrOn0A99qwX1wmFewh3UJ4QOpYgjE8QTyVdEUnDFdiB2vybrRjWD9kqROQslVG2CtYU+P2aDvLJa2Rdau/mTOyWM+Vn9a/dM55tDuwwD/VJWw97/f2f0YYXs+29OhTZXPKLRLGTURhQgOK6afX6x7EUsPJp+7n2D38FSqskgh4RxU7nf+Ja7YLsqaJCNdLj9yfvOBvBZdHpsf7yykSX9Fdkl9Dqrgg9e6HRmWK4cEULq5JObWyKnizHJEMXCJeGTWO3Z3hxh6fw6c84a6AD2PvckPxpUZpza2grNez+EonBuq0YKgARhv9ZpqOVoKJ6W9Xg7PYZRAOMsAgWFasLZQxgJtne7U4d/Tlp6xWeDr9DbTdqFTm+tsQEYynOb3EG3BsAdTrRunx5xrYPmtk4FYTC+ru6zBpq9yGwafhjwjd1G2YR3z6MToOUykC/veLi9L0uJKeHtw12qaEzs3ETn382Q== root@pve
  ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMieINuQUpTfgeZpfUYTpSO27FNJ/rMq08uxGKjW5Mv0
  EOT


  # EFI disk configuration
  efidisk {
    efitype = "4m"
    storage = "local-zfs"
    pre_enrolled_keys = false
  }

  cpu {
    cores   = 4
    sockets = 1
    type    = "host"
  }

  # Serial device for cloud-init display
  serial {
    id   = 0
    type = "socket"
  }

  disks {
    virtio {
      virtio0 {
        disk {
          storage = "local-zfs"
          size    = "8G"
          # disk_file   = "local-lvm:vm-${var.vm_id}-disk-1"
          discard = true
        }
      }
    }
    scsi {
      scsi1 {
        cloudinit {
          storage = "local-zfs"
        }
      }
    }
  }

  network {
    id     = 0
    bridge = "vmbr0"
    model  = "virtio"
  }
}
