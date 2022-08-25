data "aws_route53_zone" "apex" {
  name         = var.apex_domain
  private_zone = false
}

data "aws_acm_certificate" "apex" {
  domain   = var.apex_domain
  statuses = ["ISSUED"]
}

data "tls_public_key" "ec2_pubkey" {
  private_key_openssh = file("${path.root}/${local.private_key_filename}")
}

data "aws_secretsmanager_secret_version" "app_env" {
  secret_id = "scrt-${var.app}-app-${local.stage}-env"
}
