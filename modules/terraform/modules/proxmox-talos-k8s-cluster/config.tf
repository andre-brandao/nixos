locals {
  first_control_plane_node_ip = [for k, v in var.nodes : v.ip if v.machine_type == "controlplane"][0]
  kubernetes_endpoint         = coalesce(var.cluster.vip, local.first_control_plane_node_ip)
}

resource "talos_machine_secrets" "this" {
  // Changing talos_version causes trouble as new certs are created
}

data "talos_client_configuration" "this" {
  cluster_name         = var.cluster.name
  client_configuration = talos_machine_secrets.this.client_configuration
  nodes                = [for k, v in var.nodes : v.ip]
  endpoints            = [for k, v in var.nodes : v.ip if v.machine_type == "controlplane"]
}

data "talos_machine_configuration" "this" {
  for_each     = var.nodes
  cluster_name = var.cluster.name
  # This is the Kubernetes API Server endpoint.
  # ref - https://www.talos.dev/latest/introduction/prodnotes/#decide-the-kubernetes-endpoint
  cluster_endpoint = "https://${local.kubernetes_endpoint}:6443"
  talos_version    = var.cluster.talos_machine_config_version != null ? var.cluster.talos_machine_config_version : (each.value.update == true ? var.image.update_version : var.image.version)
  machine_type     = each.value.machine_type
  machine_secrets  = talos_machine_secrets.this.machine_secrets
  config_patches = [
    templatefile("${path.module}/machine-config/common.yaml.tftpl", {
      node_name          = each.value.host_node
      cluster_name       = var.cluster.proxmox_cluster
      kubernetes_version = var.cluster.kubernetes_version
      hostname           = each.key
      ip                 = each.value.ip
      gateway            = var.cluster.gateway
      subnet_mask        = var.cluster.subnet_mask
      vip                = each.value.machine_type == "controlplane" ? var.cluster.vip : null
    }),
    each.value.machine_type == "controlplane" ?
    templatefile("${path.module}/machine-config/control-plane.yaml.tftpl", {
      allow_scheduling_on_control_plane_nodes = var.cluster.allow_scheduling_on_control_plane_nodes
      extra_manifests                         = jsonencode(var.cluster.extra_manifests)
    }) : each.value.machine_type == "worker" ?
    templatefile("${path.module}/machine-config/worker.yaml.tftpl", {}) : ""
  ]
}

resource "talos_machine_configuration_apply" "this" {
  depends_on                  = [proxmox_virtual_environment_vm.this]
  for_each                    = var.nodes
  node                        = each.value.ip
  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.this[each.key].machine_configuration
  lifecycle {
    # re-run config apply if vm changes
    replace_triggered_by = [proxmox_virtual_environment_vm.this[each.key]]
  }
}

resource "talos_machine_bootstrap" "this" {
  depends_on = [talos_machine_configuration_apply.this]
  # Bootstrap with the first control plane node.
  # VIP not yet available at this stage, so can't use var.cluster.vip
  # ref - https://www.talos.dev/v1.9/talos-guides/network/vip/#caveats
  node                 = local.first_control_plane_node_ip
  client_configuration = talos_machine_secrets.this.client_configuration
}

data "talos_cluster_health" "this" {
  depends_on = [
    talos_machine_configuration_apply.this,
    talos_machine_bootstrap.this
  ]
  skip_kubernetes_checks = false
  client_configuration   = data.talos_client_configuration.this.client_configuration
  control_plane_nodes    = [for k, v in var.nodes : v.ip if v.machine_type == "controlplane"]
  worker_nodes           = [for k, v in var.nodes : v.ip if v.machine_type == "worker"]
  endpoints              = data.talos_client_configuration.this.endpoints
  timeouts = {
    read = "10m"
  }
}

resource "talos_cluster_kubeconfig" "this" {
  depends_on = [
    talos_machine_bootstrap.this,
    data.talos_cluster_health.this
  ]
  # The kubeconfig endpoint will be populated from the talos_machine_configuration cluster_endpoint
  node                 = local.first_control_plane_node_ip
  client_configuration = talos_machine_secrets.this.client_configuration
  timeouts = {
    read = "1m"
  }
}
