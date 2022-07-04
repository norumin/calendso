locals {
  default_tags = {
    App    = var.app
    Module = var.module
    Stage  = var.stage
  }
  slug = "${var.app}-${var.module}-${var.stage}"

  build_args = {
    NEXT_PUBLIC_WEBAPP_URL      = "https://${var.domain}"
    NEXT_PUBLIC_APP_URL         = "https://${var.domain}"
    NEXT_PUBLIC_LICENSE_CONSENT = "agree"
    CALCOM_TELEMETRY_DISABLED   = "1"
    DATABASE_URL                = "postgresql://${var.app_container_env_secrets.db_username}:${var.app_container_env_secrets.db_password}@${var.db_endpoint}/${var.app_container_env_secrets.db_name}"
    NEXTAUTH_SECRET             = var.app_container_env_secrets.auth_secret
    CALENDSO_ENCRYPTION_KEY     = var.app_container_env_secrets.encryption_key
  }
}
