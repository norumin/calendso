output "app_url" {
  description = "URL for this app"
  value       = "https://${var.domain}"
}

output "app_lb_dns_name" {
  description = "Domain name of app load balancer"
  value       = module.end.app_lb_dns_name
  sensitive   = true
}

output "db_endpoint" {
  description = "Endpoint of the database"
  value       = module.data.db_endpoint
  sensitive   = true
}

output "app_image_build_args" {
  description = "Build-time arguments of app docker image"
  value = {
    STAGE                       = var.stage
    ECR_REPO_URL                = module.root.ecr_repo_url
    NEXT_PUBLIC_LICENSE_CONSENT = "agree"
    NEXT_PUBLIC_WEBAPP_URL      = "https://${var.domain}"
    NEXT_PUBLIC_APP_URL         = "https://${var.domain}"
    NEXTAUTH_SECRET             = local.app_env_secrets.auth_secret
    CALENDSO_ENCRYPTION_KEY     = local.app_env_secrets.encryption_key
    CALCOM_TELEMETRY_DISABLED   = "1"
  }
  sensitive = true
}
