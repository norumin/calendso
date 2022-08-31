data "aws_ecr_repository" "app" {
  name = var.ecr_repo_name
}

data "aws_ecr_authorization_token" "app" {
}
