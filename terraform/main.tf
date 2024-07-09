terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.8.0"

  backend "s3" {
    bucket = "tfstate-store-a5gnpkub"
    region = "ap-northeast-1"
    key = "eks-grafana/terraform.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region = "ap-northeast-1"
  default_tags {
    tags = {
      PROJECT_NAME = "EKS_GRAFANA"
    }
  }
}

data "aws_caller_identity" "self" { }
data "aws_region" "self" {}

output "grafana_ecr_repository" {
  value = aws_ecr_repository.grafana.repository_url
}

locals {
  app_name = "eks-grafana"
  account_id = data.aws_caller_identity.self.account_id
  aws_region = data.aws_region.self.name
}

/**
 * ECR リポジトリ
 */
resource "aws_ecr_repository" "grafana" {
  name                 = "${local.app_name}/grafana"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
