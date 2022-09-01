terraform {
  required_version = ">= 1.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.21"
    }
  }
}

module "root" {
  source = "./modules/calendso-root"

  stage       = var.stage
  vpc_cidr    = "10.0.0.0/16"
  vpc_subnets = 3
}

module "app" {
  source = "./modules/calendso-app"

  stage         = var.stage
  subnet_id     = module.root.public_subnet_ids[0]
  sg_ids        = module.root.app_instance_sg_ids
  instance_type = "t2.micro"
  pubkey        = local.app_env_secrets.app_instance_public_key
}

module "data" {
  source = "./modules/calendso-data"

  stage                    = var.stage
  db_subnet_group_name     = module.root.db_subnet_group_name
  sg_ids                   = module.root.db_instance_sg_ids
  db_instance_class        = "db.t4g.micro"
  db_engine                = "postgres"
  db_engine_version        = "14.2"
  db_allocated_storage     = 5
  db_max_allocated_storage = 18
  db_username              = local.app_env_secrets.db_username
  db_password              = local.app_env_secrets.db_password
  db_name                  = local.app_env_secrets.db_name
}

module "log" {
  source = "./modules/calendso-log"

  stage = var.stage
}

module "end" {
  source = "./modules/calendso-end"

  stage                = var.stage
  domain               = var.domain
  route53_apex_zone_id = data.aws_route53_zone.apex.zone_id
  route53_default_ttl  = 3600
  acm_apex_cert_arn    = data.aws_acm_certificate.apex.arn
  vpc_id               = module.root.vpc_id
  app_instance_id      = module.app.instance_id
  app_lb_subnet_ids    = module.root.public_subnet_ids
  app_lb_sg_ids        = module.root.app_lb_sg_ids
  app_lb_log_bucket    = module.log.app_lb_log_bucket
  app_lb_tg_port       = 80
}

module "build" {
  source = "./modules/calendso-build"

  stage         = var.stage
  calendso_ref  = "v1.9.2"
  ecr_repo_name = module.root.ecr_repo_name
  build_env = {
    NEXT_PUBLIC_LICENSE_CONSENT = "agree"
    NEXT_PUBLIC_WEBAPP_URL      = "https://${var.domain}"
    NEXT_PUBLIC_APP_URL         = "https://${var.domain}"
    NEXTAUTH_SECRET             = local.app_env_secrets.auth_secret
    CALENDSO_ENCRYPTION_KEY     = local.app_env_secrets.encryption_key
    CALCOM_TELEMETRY_DISABLED   = "1"
  }
}

module "provision" {
  source = "./modules/calendso-provision"
  depends_on = [
    module.root,
    module.app,
    module.data,
    module.log,
    module.end,
    module.build,
  ]

  stage                     = var.stage
  domain                    = var.domain
  app_instance_public_ip    = module.app.instance_public_ip
  app_keypair_path          = "${path.root}/${local.keypair_filename}"
  db_endpoint               = module.data.db_endpoint
  ecr_repo_name             = module.root.ecr_repo_name
  app_image_tag             = module.build.app_image_tag
  app_container_count       = 1
  app_container_name_prefix = local.app_container_name_prefix
  app_container_ports       = "80:${module.build.app_image_http_port}"
  app_container_log_group   = module.log.app_container_log_group
  app_container_env_secrets = local.app_env_secrets
}
