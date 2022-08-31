data "aws_region" "current" {}

data "aws_ecr_repository" "app" {
  name = var.ecr_repo_name
}

data "aws_ecr_image" "app" {
  repository_name = var.ecr_repo_name
  image_tag       = var.app_image_tag
}
