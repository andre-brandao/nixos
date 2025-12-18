data "gitea_repo" "this" {
  username = var.flux_bootstrap_repo.username
  name     = var.flux_bootstrap_repo.name
}

resource "tls_private_key" "ed25519" {
  algorithm = "ED25519"
}

resource "gitea_repository_key" "this" {
  title      = "${var.cluster.name}-flux"
  repository = data.gitea_repo.this.id
  key        = trimspace(tls_private_key.ed25519.public_key_openssh)
  read_only  = false
}

resource "flux_bootstrap_git" "this" {
  depends_on = [
    gitea_repository_key.this,
    data.talos_cluster_health.this
  ]

  embedded_manifests = true
  path               = "clusters/${var.cluster.name}"
}
