variable "task_name" {}

variable "log_group_prefix" {
  description = "Cloudwatch log group name prefix"
  default     = "ecs"
}

variable "container_image" {}

variable "container_port" {
  default = "false"
}

variable "cpu" {
  default = 512
}

variable "memory" {
  default = 1024
}

variable "aws_region" {}

variable "mount_points" {
  type    = "list"
  default = []
}

variable "command" {
  type    = "list"
  default = []
}

variable "launch_types" {
  type    = "list"
  default = ["FARGATE", "EC2"]
}

variable "env_vars" {
  description = "Environment variables to pass to the container"
  type        = "map"
  default     = {}
}

variable "env_vars_length" {
  default = 0
}

variable "secret_env_vars" {
  description = "Secret environment variables to pass to the container"
  type        = "map"
  default     = {}
}

variable "secret_env_vars_length" {
  default = 0
}
