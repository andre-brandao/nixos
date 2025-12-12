terraform {
  backend "s3" {
    bucket = "terraform"
    key    = "nix-iso/terraform.tfstate"
    region = "us-east-1"

    # MinIO-specific configuration
    endpoint                    = "http://truenas:9000"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    force_path_style            = true # Required for MinIO
    # Access credentials (use environment variables for security)
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
  # proxmox.imkumpy.in is reverse proxied through another host which causes issues
  # when this provider tries to SSH, so we use the direct IP address here.
  endpoint = "https://pve:8006/"

  username = "terraform-prov@pve"
  # api_token = var.proxmox_api_token


  # because self-signed TLS certificate is in use
  insecure = true

  tmp_dir = "/var/tmp"


  ssh {
    # address = "pve"
    agent       = true
    username    = "root"
    private_key = file("~/.ssh/id_ed25519")
    # node {
    #   name    = "pve"
    #   # address = "100.104.247.4"
    # }
  }
}
