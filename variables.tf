variable "cluster_name" {
  description = "A name to provide for the Talos cluster"
  type        = string
  default     = "talos-cluster-1"
}

variable "proxmox_endpoint" {
  description = "The endpoint for the Proxmox cluster"
  type        = string
  default     = "https://192.168.1.99:8006"
}

variable "cluster_endpoint" {
  description = "The endpoint for the Talos cluster"
  type        = string
  default     = "https://192.168.1.100:6443"
}

variable "node_data" {
  description = "A map of node data"
  type = object({
    controlplanes = map(object({
      install_disk = string
      hostname     = optional(string)
      gw           = string
    }))
    workers = map(object({
      install_disk = string
      hostname     = optional(string)
      gw           = string
    }))
  })
  default = {
    controlplanes = {
      "192.168.1.100" = {
        install_disk = "/dev/sda"
        gw           = "192.168.1.1"
      },
    #   "192.168.1.101" = {
    #     install_disk = "/dev/sda"
    #     gw           = "192.168.1.1"        
    #   },
    #   "192.168.1.102" = {
    #     install_disk = "/dev/sda"
    #     gw           = "192.168.1.1"
    #   }
    }
    workers = {
      "192.168.1.105" = {
        install_disk = "/dev/sda"
        gw           = "192.168.1.1"
      },
      # "192.168.1.106" = {
      #   install_disk = "/dev/sda"
      #   gw           = "192.168.1.1"
      # },
      #   "192.168.1.107" = {
      #   install_disk = "/dev/sda"
      #   gw           = "192.168.1.1"
      # }
    }
  }
}