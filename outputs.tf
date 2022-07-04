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
      local.app_env_secrets.db_username,
      ":",
      local.app_env_secrets.db_password,
      "@",
      module.data.db_endpoint,
      "/",
      local.app_env_secrets.db_name
    ])
    NEXTAUTH_SECRET         = local.app_env_secrets.auth_secret
    CALENDSO_ENCRYPTION_KEY = local.app_env_secrets.encryption_key
  }
  sensitive = true
}
