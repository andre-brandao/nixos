terraform {
  backend "s3" {
        bucket = "terraform"
        key    = "${vars.project_name}/terraform.tfstate"
        region = "us-east-1"

        # MinIO-specific configuration
        endpoint                    = vars.s3_endpoint
        skip_credentials_validation = true
        skip_metadata_api_check     = true
        skip_region_validation      = true
        force_path_style            = true  # Required for MinIO
        access_key = vars.s3_acess_key
        secret_key = vars.s3_secret_key

        # Access credentials (use environment variables for security)
        # access_key = "your-access-key"  # Better to use AWS_ACCESS_KEY_ID env var
        # secret_key = "your-secret-key"  # Better to use AWS_SECRET_ACCESS_KEY env var
  }
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc05"
    }
  }
  # required_version = "value"
}

provider "proxmox" {
  # Configuration options
  pm_api_url      = "https://pve:8006/api2/json"
  pm_tls_insecure = true # By default Proxmox Virtual Environment uses self-signed certificates.
  pm_user         = "terraform-prov@pve"
  pm_debug = true
}
