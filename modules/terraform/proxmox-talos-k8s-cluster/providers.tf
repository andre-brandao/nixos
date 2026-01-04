terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">=0.66.1"
    }
    talos = {
      source  = "siderolabs/talos"
      version = ">=0.6.0"
    }
    http = {
      source  = "hashicorp/http"
      version = ">=3.4.5"
    }
    flux = {
      source  = "fluxcd/flux"
      version = ">=1.5.1"
    }
    gitea = {
      source  = "go-gitea/gitea"
      version = ">=0.6.0"
    }
  }
}

provider "flux" {
  kubernetes = {
    host                   = talos_cluster_kubeconfig.this.kubernetes_client_configuration.host
    client_certificate     = base64decode(talos_cluster_kubeconfig.this.kubernetes_client_configuration.client_certificate)
    client_key             = base64decode(talos_cluster_kubeconfig.this.kubernetes_client_configuration.client_key)
    cluster_ca_certificate = base64decode(talos_cluster_kubeconfig.this.kubernetes_client_configuration.ca_certificate)
  }
  git = {
    url = "ssh://${var.git_config.user}@${var.git_config.domain}/${var.flux_bootstrap_repo.username}/${var.flux_bootstrap_repo.name}.git"
    ssh = {
      username    = "git"
      private_key = tls_private_key.ed25519.private_key_openssh
    }
  }
}
