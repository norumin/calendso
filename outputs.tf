output "app_url" {
  description = "URL for this app"
  value       = "https://${var.domain}"
}

output "app_urls" {
  description = "All URLs for this app (including alternative domains)"
  value       = concat(["https://${var.domain}"], [for name in var.alternative_domains : "https://${name}"])
}

output "app_lb_dns_name" {
  description = "Domain name of app load balancer"
  value       = module.end.app_lb_dns_name
  sensitive   = true
}

output "app_image_build_args" {
  description = "Build-time arguments of app docker image"
  value = {
    NEXT_PUBLIC_WEBAPP_URL      = "https://${var.domain}"
    NEXT_PUBLIC_APP_URL         = "https://${var.domain}"
    NEXT_PUBLIC_LICENSE_CONSENT = "agree"
    CALCOM_TELEMETRY_DISABLED   = "1"
    DATABASE_URL = join("", [
      "postgresql://",
      data.aws_secretsmanager_secret_version.app_env.db_username,
      ":",
      data.aws_secretsmanager_secret_version.app_env.db_password,
      "@",
      module.data.db_endpoint,
      "/",
      data.aws_secretsmanager_secret_version.app_env.db_name
    ])
    NEXTAUTH_SECRET         = data.aws_secretsmanager_secret_version.auth_secret
    CALENDSO_ENCRYPTION_KEY = data.aws_secretsmanager_secret_version.encryption_key
  }
  sensitive = true
}
