variable "az_count" {
  default = "4"
}

variable "vpc_id" {}
variable "name" {}
variable "cidr_block" {}
variable "cidrsubnet_newbits" {}

variable "map_public_ips_on_launch" {
  default = false
}
