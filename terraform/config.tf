terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  required_version = ">= 0.14"
}

provider "aws" {
  region = "eu-central-1"

  default_tags {
    tags = {
      application = var.app
      env         = var.env
    }
  }
}
