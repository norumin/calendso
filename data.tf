data "aws_route53_zone" "apex" {
  name         = local.apex_domain
  private_zone = false
}

data "aws_acm_certificate" "apex" {
  domain   = local.apex_domain
  statuses = ["ISSUED"]
}

data "aws_secretsmanager_secret_version" "app_env" {
  secret_id = "scrt-${var.app}-app-${var.stage}-env"
}
