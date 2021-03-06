variable "task_name" {}

variable "memory" {
  description = "How much memory to allocate to the app"
  default     = 1024
}

variable "cpu" {
  description = "How much CPU to allocate to the app"
  default     = 512
}

variable "task_definition_rendered" {}

variable "ebs_host_path" {}
variable "ebs_container_path" {}
