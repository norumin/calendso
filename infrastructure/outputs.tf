output "app_url" {
  description = "URL for this app"
  value       = "https://${var.domain}"
}

# output "app_lb_dns_name" {
#   description = "Domain name of app load balancer"
#   value       = module.end.app_lb_dns_name
#   sensitive   = true
# }

output "app_image_build_args" {
  description = "Build-time arguments of app docker image"
  value = {
    STAGE                       = var.stage
    POSTGRES_USER               = local.app_env_secrets.db_username
    POSTGRES_PASSWORD           = local.app_env_secrets.db_password
    POSTGRES_DB                 = local.app_env_secrets.db_name
    CALENDSO_REF                = var.calendso_ref
    ECR_REPO_URL                = module.image.ecr_repo_url
    NEXT_PUBLIC_LICENSE_CONSENT = "agree"
    NEXT_PUBLIC_WEBAPP_URL      = "https://${var.domain}"
    NEXT_PUBLIC_APP_URL         = "https://${var.domain}"
    DATABASE_URL = join("", [
      "postgresql://",
      local.app_env_secrets.db_username,
      ":",
      local.app_env_secrets.db_password,
      "@",
      local.db_instance_hostname,
      "/",
      local.app_env_secrets.db_name
    ])
    NEXTAUTH_SECRET           = local.app_env_secrets.auth_secret
    CALENDSO_ENCRYPTION_KEY   = local.app_env_secrets.encryption_key
    CALCOM_TELEMETRY_DISABLED = "1"
  }
  sensitive = true
}
