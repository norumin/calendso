locals {
  db_instance_hostname = "database"

  apex_domain = join(".", slice(
    split(".", var.domain),
    length(split(".", var.domain)) - 2,
    length(split(".", var.domain))
    )
  ) # Extract apex domain from app domainex

  app_container_name_prefix = "app"
  keypair_filename          = ".keypair.pem"
  app_env_secrets           = jsondecode(data.aws_secretsmanager_secret_version.app_env.secret_string)
}
