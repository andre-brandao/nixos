terraform {
  backend "s3" {
    bucket = "terraform"
    key    = "nix-pve-builder/terraform.tfstate"
    region = "us-east-1"

    # MinIO-specific configuration
    endpoint                    = "http://truenas:9000"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    force_path_style            = true # Required for MinIO
    # access_key = "your-access-key"  # Better to use AWS_ACCESS_KEY_ID env var
    # secret_key = "your-secret-key"  # Better to use AWS_SECRET_ACCESS_KEY env var
  }
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.89.1"
    }
  }
}
provider "proxmox" {
  endpoint = "https://pve:8006/"

  username = "terraform-prov@pve"

  # because self-signed TLS certificate is in use
  insecure = true

  tmp_dir = "/var/tmp"

  ssh {
    agent       = true
    username    = "root"
    private_key = file("~/.ssh/id_ed25519")
  }
}
