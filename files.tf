locals {
  talos = {
    version = "v1.8.4"
  }
}

resource "proxmox_virtual_environment_download_file" "talos_nocloud_image" {
  content_type            = "iso"
  datastore_id            = "local"
  node_name               = "void"

  file_name               = "talos-${local.talos.version}-nocloud-amd64.img"
  url                     = "https://factory.talos.dev/image/dc7b152cb3ea99b821fcb7340ce7168313ce393d663740b791c36f6e95fc8586/${local.talos.version}/nocloud-amd64.raw.xz"
  decompression_algorithm = "zst"
  overwrite               = false
  upload_timeout          = 4444
}