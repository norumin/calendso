locals {
  default_tags = {
    App    = var.app
    Module = var.module
    Stage  = var.stage
  }
  slug = "${var.app}-${var.module}-${var.stage}"

  default_app_image_tag = "latest"
  ecr_token = data.aws_ecr_authorization_token.app.authorization_token
  ecr_url = data.aws_ecr_repository.app.repository_url
}
