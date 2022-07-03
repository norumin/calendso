terraform {
  required_version = ">= 1.2"

  backend "s3" {
    encrypt        = true
    region         = "us-east-2"
    bucket         = "tf-common-backend"
    key            = "calendso/terraform.tfstate"
    dynamodb_table = "tf-common-backend"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.21"
    }
  }
}

module "root" {
  source = "./modules/calendso-root"

  stage       = local.stage
  vpc_cidr    = "10.0.0.0/16"
  vpc_subnets = 3
}

module "app" {
  source = "./modules/calendso-app"

  stage         = local.stage
  subnet_id     = module.root.public_subnet_ids[0]
  sg_ids        = module.root.app_instance_sg_ids
  instance_type = "t2.micro"
  pubkey        = trimspace(data.tls_public_key.ec2_pubkey.public_key_openssh)
}

module "data" {
  source = "./modules/calendso-data"

  stage                    = local.stage
  public_subnet_ids        = module.root.public_subnet_ids
  private_subnet_ids       = module.root.private_subnet_ids
  sg_ids                   = module.root.db_instance_sg_ids
  db_instance_class        = "db.t4g.micro"
  db_engine                = "postgres"
  db_engine_version        = "13.6"
  db_allocated_storage     = 5
  db_max_allocated_storage = 18
  db_username              = local.app_env.db_username
  db_password              = local.app_env.db_password
  db_name                  = "calendso"
  db_publicly_accessible   = false
}

module "log" {
  source = "./modules/calendso-log"

  stage = local.stage
}

module "end" {
  source = "./modules/calendso-end"

  stage                = local.stage
  domain               = var.domain
  alternative_domains  = var.alternative_domains
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
