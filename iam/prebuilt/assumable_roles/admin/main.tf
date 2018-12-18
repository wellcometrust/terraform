module "admin" {
  source     = "../../../modules/assumable_role"
  name       = "admin"
  principals = ["${var.principals}"]
}

resource "aws_iam_role_policy" "admin" {
  role   = "${module.admin.arn}"
  policy = "${data.aws_iam_policy.admin.arn}"
}

data "aws_iam_policy" "admin" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
