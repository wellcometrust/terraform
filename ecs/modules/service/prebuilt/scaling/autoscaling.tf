module "appautoscaling" {
  source = "../../../../../autoscaling/app/ecs"
  name   = "${module.service.name}"

  cluster_name = "${var.cluster_name}"
  service_name = "${module.service.name}"

  min_capacity = "${var.min_capacity}"
  max_capacity = "${var.max_capacity}"
}
