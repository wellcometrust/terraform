module "service" {
  source              = "./ecs_service"
  service_name        = "${var.name}"
  cluster_id          = "${var.cluster_id}"
  task_definition_arn = "${module.task.arn}"
  vpc_id              = "${var.vpc_id}"
  container_name      = "${var.primary_container_name}"
  container_port      = "${var.primary_container_port}"
  listener_https_arn  = "${var.listener_https_arn}"
  listener_http_arn   = "${var.listener_http_arn}"
  path_pattern        = "${var.path_pattern}"
  alb_priority        = "${var.alb_priority}"
  desired_count       = "${var.desired_count}"
  healthcheck_path    = "${var.healthcheck_path}"
  infra_bucket        = "${var.infra_bucket}"
  host_name           = "${var.host_name}"

  client_error_alarm_topic_arn = "${var.client_error_alarm_topic_arn}"
  server_error_alarm_topic_arn = "${var.server_error_alarm_topic_arn}"
  loadbalancer_cloudwatch_id   = "${var.loadbalancer_cloudwatch_id}"

  deployment_minimum_healthy_percent = "${var.deployment_minimum_healthy_percent}"
  deployment_maximum_percent         = "${var.deployment_maximum_percent}"

  enable_alb_alarm = "${var.enable_alb_alarm}"
}

module "task" {
  source           = "./ecs_tasks"
  task_name        = "${var.name}"
  task_role_arn    = "${var.task_role_arn}"
  volume_name      = "${var.volume_name}"
  volume_host_path = "${var.volume_host_path}"
  app_uri          = "${var.app_uri}"
  nginx_uri        = "${var.nginx_uri}"
  template_name    = "${var.template_name}"
  cpu              = "${var.cpu}"
  memory           = "${var.memory}"

  primary_container_port   = "${var.primary_container_port}"
  secondary_container_port = "${var.secondary_container_port}"
  container_path           = "${var.container_path}"

  service_vars = [
    "{ \"name\" : \"INFRA_BUCKET\", \"value\" : \"${var.infra_bucket}\" }",
    "{ \"name\" : \"CONFIG_KEY\", \"value\" : \"${var.config_key}\" }",
  ]

  extra_vars = "${var.extra_vars}"
}

locals {
  default_path         = "templates/${var.name}.ini.template"
  config_template_path = "${var.config_template_path == "" ? local.default_path : var.config_template_path}"
}

module "config" {
  source        = "git::https://github.com/wellcometrust/terraform.git//services?ref=v1.2.0"
  s3_bucket     = "${var.infra_bucket}"
  s3_key        = "${var.config_key}"
  template_vars = "${var.config_vars}"
  template_path = "${local.config_template_path}"
  enabled       = "${var.is_config_managed}"
}
