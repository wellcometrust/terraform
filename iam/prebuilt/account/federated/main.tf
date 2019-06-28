data "aws_caller_identity" "current" {}

locals {
  account_id        = "${data.aws_caller_identity.current.account_id}"
  iam_saml_provider = "${var.prefix}-saml_provider"
  principal = "arn:aws:iam::${local.account_id}:saml-provider/${local.iam_saml_provider}"
}

# SAML

resource "aws_iam_saml_provider" "saml_provider" {
  name                   = "${local.iam_saml_provider}"
  saml_metadata_document = "${var.saml_xml}"
}

# List roles user

module "list_roles_user" {
  source = "../../users/list_roles_user"
  
  pgp_key = "${var.pgp_key}"
  prefix  = "${var.prefix}"
}

# Roles

module "admin_role" {
  source     = "../../../modules/assumable_role/federated"
  name       = "${var.prefix}-admin"
  principals = ["${local.principal}"]
}

module "admin_role_policy" {
  source = "../../role_policies/admin"
  role_name = "${module.admin_role.name}"
}

module "billing_role" {
  source     = "../../../modules/assumable_role/federated"
  name       = "${var.prefix}-billing"
  principals = ["${local.principal}"]
}

module "billing_role_policy" {
  source = "../../role_policies/billing"
  role_name = "${module.billing_role.name}"
}

module "developer_role" {
  source     = "../../../modules/assumable_role/federated"
  name       = "${var.prefix}-developer"
  principals = ["${local.principal}"]
}

module "developer_role_policy" {
  source = "../../role_policies/developer"
  role_name = "${module.developer_role.name}"
}

module "infrastructure_role" {
  source     = "../../../modules/assumable_role/infrastructure"
  name       = "${var.prefix}-infrastructure"
  principals = ["${local.principal}"]
}

module "infrastructure_role_policy" {
  source = "../../role_policies/infrastructure"
  role_name = "${module.infrastructure_role.name}"
}

module "monitoring_role" {
  source     = "../../../modules/assumable_role/monitoring"
  name       = "${var.prefix}-monitoring"
  principals = ["${local.principal}"]
}

module "monitoring_role_policy" {
  source = "../../role_policies/monitoring"
  role_name = "${module.monitoring_role.name}"
}

module "read_only_role" {
  source     = "../../../modules/assumable_role/read_only"
  name       = "${var.prefix}-read_only"
  principals = ["${local.principal}"]
}

module "read_only_role_policy" {
  source = "../../role_policies/read_only"
  role_name = "${module.read_only_role.name}"
}