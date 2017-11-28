data "template_file" "config" {
  template = "${file("${path.cwd}/templates/${var.app_name}.ini.template")}"
  vars     = "${var.template_vars}"
  count    = "${var.is_config_managed}"
}
