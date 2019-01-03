resource "aws_api_gateway_deployment" "stage" {
  rest_api_id = "${var.api_id}"
  stage_name  = "${var.stage_name}"

  variables = "${merge(var.variables, map("dependencies_md5", md5(join(",", var.depends_on))))}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "stage" {
  stage_name    = "${var.stage_name}"
  rest_api_id   = "${var.api_id}"
  deployment_id = "${aws_api_gateway_deployment.stage.id}"

  variables = "${merge(var.variables, map("dependencies_md5", md5(join(",", var.depends_on))))}"


}
