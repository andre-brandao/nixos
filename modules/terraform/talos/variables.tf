variable "vm_id" {
  default = 101
}

variable "project_name" {
  default = "talos-vm"
}

variable "s3_endpoint" {
  type = string
  default = "http://truenas:9000"
}

variable "s3_acess_key" {
  type = string
  default = "minio"
}

variable "s3_secret_key" {
  type = string
}
