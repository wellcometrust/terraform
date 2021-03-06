output "service_name" {
  value = "${module.service.service_name}"
}

output "task_definition_arn" {
  value = "${module.task.task_definition_arn}"
}

output "container_port" {
  value = "${var.container_port}"
}

output "task_role_name" {
  value = "${module.task.task_role_name}"
}

output "task_role_arn" {
  value = "${module.task.task_role_arn}"
}
