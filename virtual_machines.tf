resource "proxmox_virtual_environment_vm" "control_planes" {
  for_each = var.node_data.controlplanes
  name     = each.value.hostname == null ? format("%s-cp-%s", var.cluster_name, index(keys(var.node_data.controlplanes), each.key)) : each.value.hostname
  description = "Managed by Terraform"
  tags        = ["terraform"]
  node_name   = "void"
  on_boot     = true

  cpu {
    cores = 2
    type = "x86-64-v2-AES"
  }

  memory {
    dedicated = 4096
  }

  agent {
    enabled = true
  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = "local-zfs"
    file_id      = proxmox_virtual_environment_download_file.talos_nocloud_image.id
    file_format  = "raw"
    interface    = "virtio0"
    size         = 20
  }

  operating_system {
    type = "l26" # Linux Kernel 2.6 - 5.X.
  }

  initialization {
    datastore_id = "local-zfs"
    ip_config {
      ipv4 {
        address = "${each.key}/24"
        gateway = each.value.gw
      }
      ipv6 {
        address = "dhcp"
      }
    }
  }
}

resource "proxmox_virtual_environment_vm" "workers" {
  depends_on = [ proxmox_virtual_environment_vm.control_planes ]
  for_each = var.node_data.workers
  name     = each.value.hostname == null ? format("%s-worker-%s", var.cluster_name, index(keys(var.node_data.workers), each.key)) : each.value.hostname
  description = "Managed by Terraform"
  tags        = ["terraform"]
  node_name   = "void"
  on_boot     = true

  cpu {
    cores = 4
    type = "x86-64-v2-AES"
  }

  memory {
    dedicated = 4096
  }

  agent {
    enabled = true
  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = "local-zfs"
    file_id      = proxmox_virtual_environment_download_file.talos_nocloud_image.id
    file_format  = "raw"
    interface    = "virtio0"
    size         = 20
  }

  operating_system {
    type = "l26" # Linux Kernel 2.6 - 5.X.
  }

  initialization {
    datastore_id = "local-zfs"
    ip_config {
      ipv4 {
        address = "${each.key}/24"
        gateway = each.value.gw
      }
      ipv6 {
        address = "dhcp"
      }
    }
  }
}