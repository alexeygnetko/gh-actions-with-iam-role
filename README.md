# Demo of GH Action authentication with IAM role

This is a demo code for the post: [AWS in GitHub Actions: authenticate with IAM roles and forget about Access Keys](https://alexey-gnetko.com/posts/gh-actions-and-aws-with-oidc-and-terraform/).

## Usage

The code can be used as a reference. If you fork this repository and want to make it work, please follow these steps:

1. Adjust a repository name and other variables in [variables.tf](terraform/variables.tf)
2. Add policies you need to the assumable IAM role in [iam.tf](terraform/iam.tf)
3. Apply Terraform:
```bash
cd terraform
terraform apply
```
4. Put an IAM role ARN from Terraform Outputs to [verify-iam-role.yml](.github/workflows/verify-iam-role.yml) workflow

