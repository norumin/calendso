locals {
  stage = terraform.workspace

  private_key_filename = "kp-${var.app}-app-${terraform.workspace}.pem"
  app_env              = jsondecode(data.aws_secretsmanager_secret_version.app_env.secret_string)
}
