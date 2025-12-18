# proxmox-talos-k8s-cluster

Credit goes to Vegard Hagen (github user vehagn) for the base of this module
that I have modified to my needs. [LINK](https://github.com/vehagn/homelab)

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                               | Version  |
| ------------------------------------------------------------------ | -------- |
| <a name="requirement_flux"></a> [flux](#requirement_flux)          | >=1.5.1  |
| <a name="requirement_gitea"></a> [gitea](#requirement_gitea)       | >=0.6.0  |
| <a name="requirement_http"></a> [http](#requirement_http)          | >=3.4.5  |
| <a name="requirement_proxmox"></a> [proxmox](#requirement_proxmox) | >=0.66.1 |
| <a name="requirement_talos"></a> [talos](#requirement_talos)       | >=0.6.0  |

## Providers

| Name                                                         | Version  |
| ------------------------------------------------------------ | -------- |
| <a name="provider_flux"></a> [flux](#provider_flux)          | >=1.5.1  |
| <a name="provider_gitea"></a> [gitea](#provider_gitea)       | >=0.6.0  |
| <a name="provider_http"></a> [http](#provider_http)          | >=3.4.5  |
| <a name="provider_proxmox"></a> [proxmox](#provider_proxmox) | >=0.66.1 |
| <a name="provider_talos"></a> [talos](#provider_talos)       | >=0.6.0  |
| <a name="provider_tls"></a> [tls](#provider_tls)             | n/a      |

## Modules

No modules.

## Resources

| Name                                                                                                                                                          | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [flux_bootstrap_git.this](https://registry.terraform.io/providers/fluxcd/flux/latest/docs/resources/bootstrap_git)                                            | resource    |
| [gitea_repository_key.this](https://registry.terraform.io/providers/go-gitea/gitea/latest/docs/resources/repository_key)                                      | resource    |
| [proxmox_virtual_environment_download_file.this](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_download_file) | resource    |
| [proxmox_virtual_environment_vm.this](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm)                       | resource    |
| [talos_cluster_kubeconfig.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/cluster_kubeconfig)                            | resource    |
| [talos_image_factory_schematic.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/image_factory_schematic)                  | resource    |
| [talos_machine_bootstrap.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/machine_bootstrap)                              | resource    |
| [talos_machine_configuration_apply.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/machine_configuration_apply)          | resource    |
| [talos_machine_secrets.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/resources/machine_secrets)                                  | resource    |
| [tls_private_key.ed25519](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key)                                            | resource    |
| [gitea_repo.this](https://registry.terraform.io/providers/go-gitea/gitea/latest/docs/data-sources/repo)                                                       | data source |
| [http_http.schematic_id](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http)                                                | data source |
| [http_http.updated_schematic_id](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http)                                        | data source |
| [talos_client_configuration.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/client_configuration)                     | data source |
| [talos_cluster_health.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/cluster_health)                                 | data source |
| [talos_machine_configuration.this](https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/machine_configuration)                   | data source |

## Inputs

| Name                                                                                       | Description                                              | Type                                                                                                                                                                                                                                                                                                                                                                                                              | Default | Required |
| ------------------------------------------------------------------------------------------ | -------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_cluster"></a> [cluster](#input_cluster)                                     | Cluster configuration                                    | <pre>object({<br/> name = string<br/> vip = optional(string)<br/> gateway = string<br/> subnet_mask = optional(string, "16")<br/> talos_machine_config_version = optional(string)<br/> proxmox_cluster = string<br/> kubernetes_version = string<br/> allow_scheduling_on_control_plane_nodes = optional(bool, false)<br/> extra_manifests = optional(list(string))<br/> })</pre>                                 | n/a     |   yes    |
| <a name="input_flux_bootstrap_repo"></a> [flux_bootstrap_repo](#input_flux_bootstrap_repo) | username/name for the gitea repository with fluxcd setup | <pre>object({<br/> username = string<br/> name = string<br/> })</pre>                                                                                                                                                                                                                                                                                                                                             | n/a     |   yes    |
| <a name="input_image"></a> [image](#input_image)                                           | Talos image configuration                                | <pre>object({<br/> factory_url = optional(string, "https://factory.talos.dev")<br/> schematic_path = string<br/> version = string<br/> update_schematic_path = optional(string)<br/> update_version = optional(string)<br/> arch = optional(string, "amd64")<br/> platform = optional(string, "nocloud")<br/> proxmox_datastore = optional(string, "local")<br/> file_prefix = optional(string, "")<br/> })</pre> | n/a     |   yes    |
| <a name="input_nodes"></a> [nodes](#input_nodes)                                           | Configuration for cluster nodes                          | <pre>map(object({<br/> host_node = string<br/> machine_type = string<br/> datastore_id = optional(string, "samsung-500gb")<br/> ip = string<br/> dns = optional(list(string))<br/> network_bridge = string<br/> vm_id = number<br/> cpu = number<br/> ram_dedicated = number<br/> disk_size = optional(number)<br/> update = optional(bool, false)<br/> igpu = optional(bool, false)<br/> }))</pre>               | n/a     |   yes    |

## Outputs

| Name                                                                                            | Description |
| ----------------------------------------------------------------------------------------------- | ----------- |
| <a name="output_client_configuration"></a> [client_configuration](#output_client_configuration) | n/a         |
| <a name="output_kube_config"></a> [kube_config](#output_kube_config)                            | n/a         |
| <a name="output_machine_config"></a> [machine_config](#output_machine_config)                   | n/a         |
| <a name="output_machine_secrets"></a> [machine_secrets](#output_machine_secrets)                | n/a         |

<!-- END_TF_DOCS -->
