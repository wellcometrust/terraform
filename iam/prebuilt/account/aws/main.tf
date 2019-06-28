data "aws_caller_identity" "current" {}

locals {
  account_id        = "${data.aws_caller_identity.current.account_id}"
  iam_saml_provider = "${var.prefix}-saml_provider"
  principal         = "arn:aws:iam::${local.account_id}:saml-provider/${local.iam_saml_provider}"
}

# Roles

module "admin_role" {
  source     = "../../../modules/assumable_role/aws"
  name       = "${var.prefix}-admin"

  principals = ["${var.aws_principal}"]
}

module "admin_role_policy" {
  source = "../../role_policies/admin"
  role_name = "${module.admin_role.name}"
}

module "billing_role" {
  source     = "../../../modules/assumable_role/aws"
  name       = "${var.prefix}-billing"

  principals = ["${var.aws_principal}"]
}

module "billing_role_policy" {
  source = "../../role_policies/billing"
  role_name = "${module.billing_role.name}"
}

module "developer_role" {
  source     = "../../../modules/assumable_role/aws"
  name       = "${var.prefix}-developer"
  principal  = "${local.principal}"

  principals = ["${var.aws_principal}"]
}

module "developer_role_policy" {
  source = "../../role_policies/developer"
  role_name = "${module.developer_role.name}"
}

module "infrastructure_role" {
  source     = "../../../modules/assumable_role/aws"
  name       = "${var.prefix}-infrastructure"
  principal  = "${local.principal}"

  principals = ["${var.aws_principal}"]
}

module "infrastructure_role_policy" {
  source = "../../role_policies/infrastructure"
  role_name = "${module.infrastructure_role.name}"
}

module "monitoring_role" {
  source     = "../../../modules/assumable_role/aws"
  name       = "${var.prefix}-monitoring"
  principal  = "${local.principal}"

  principals = ["${var.aws_principal}"]
}

module "monitoring_role_policy" {
  source = "../../role_policies/monitoring"
  role_name = "${module.monitoring_role.name}"
}

module "read_only_role" {
  source     = "../../../modules/assumable_role/aws"
  name       = "${var.prefix}-read_only"
  principal  = "${local.principal}"

  principals = ["${var.aws_principal}"]
}

module "read_only_role_policy" {
  source = "../../role_policies/read_only"
  role_name = "${module.read_only_role.name}"
}