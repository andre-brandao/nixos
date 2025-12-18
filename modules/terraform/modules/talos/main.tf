resource "proxmox_vm_qemu" "talos" {
  agent       = 1
  memory      = 4096
  boot        = "order=virtio0;ide2"
  name        = "talos-01"
  target_node = "pve"
  scsihw      = "virtio-scsi-single"

  cpu {
    cores   = 4
    sockets = 1
    type    = "host"
  }

  disks {
    ide {
      ide2 {
        cdrom {
          iso = "shared-isos:iso/talos-v1.11.5-nocloud-amd64.iso"
        }
      }
    }
    # scsi {
    #   scsi0 {
    #     disk {
    #       storage = "local-zfs"
    #       size    = "32G"
    #       discard = true
    #     }
    #   }
    # }
    virtio {
      virtio0 {
        disk {
          storage = "local-zfs"
          size    = "32G"
          # discard = true
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
