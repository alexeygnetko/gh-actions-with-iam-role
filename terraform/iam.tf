locals {
  provider_url       = "https://token.actions.githubusercontent.com"
  github_thumbprints = ["6938fd4d98bab03faadb97b34396831e3780aea1", "1c58a3a8518e8759bf075b76b750d4f2df264fcd"]
  client_id          = "sts.amazonaws.com"
}

resource "aws_iam_openid_connect_provider" "default" {
  url             = local.provider_url
  client_id_list  = [local.client_id]
  thumbprint_list = local.github_thumbprints
}

module "assumable_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.33.1"

  create_role                    = true
  provider_url                   = local.provider_url
  role_name                      = "${var.app}-${var.env}-AssumableRole"
  oidc_fully_qualified_audiences = [local.client_id]
  oidc_fully_qualified_subjects  = ["repo:${var.repo}:ref:refs/heads/main"]

  # remove `oidc_fully_qualified_subjects` if you want to allow assuming the role from any branch
  #   oidc_subjects_with_wildcards = ["repo:${var.repo}:ref:refs/heads/*"]
}

resource "aws_iam_policy" "example_policy" {
  name        = "example-policy"
  description = "An example IAM policy"

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : "s3:ListBucket",
          "Resource" : "*"
        }
      ]
  })
}

resource "aws_iam_role_policy_attachment" "example_attachment" {
  policy_arn = aws_iam_policy.example_policy.arn
  role       = module.assumable_role.iam_role_name
}
