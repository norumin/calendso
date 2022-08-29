locals {
  default_tags = {
    App    = var.app
    Module = var.module
    Stage  = var.stage
  }
  slug = "${var.app}-${var.module}-${var.stage}"

  app_image = data.aws_ecr_repository.app.repository_url

  runtime_env = {
    NEXT_PUBLIC_LICENSE_CONSENT = "agree"
    CALCOM_LICENSE_KEY          = ""
    DATABASE_URL = join("", [
      "postgresql://",
      var.app_container_env_secrets.db_username,
      ":",
      var.app_container_env_secrets.db_password,
      "@",
      var.db_endpoint,
      "/",
      var.app_container_env_secrets.db_name
    ])
    NEXT_PUBLIC_WEBAPP_URL         = "https://${var.domain}"
    NEXT_PUBLIC_WEBSITE_URL        = "https://${var.domain}"
    NEXT_PUBLIC_CONSOLE_URL        = ""
    NEXT_PUBLIC_EMBED_LIB_URL      = ""
    SAML_DATABASE_URL              = ""
    SAML_ADMINS                    = ""
    NEXTAUTH_URL                   = "https://${var.domain}"
    NEXTAUTH_SECRET                = var.app_container_env_secrets.auth_secret
    NEXTAUTH_COOKIE_DOMAIN         = var.app_container_env_secrets.cookie_domain
    CALCOM_TELEMETRY_DISABLED      = "1"
    CRON_API_KEY                   = var.app_container_env_secrets.cron_api_key
    CALENDSO_ENCRYPTION_KEY        = var.app_container_env_secrets.encryption_key
    SEND_FEEDBACK_EMAIL            = ""
    SENDGRID_API_KEY               = ""
    SENDGRID_EMAIL                 = ""
    TWILIO_SID                     = ""
    TWILIO_TOKEN                   = ""
    TWILIO_MESSAGING_SID           = ""
    API_KEY_PREFIX                 = ""
    EMAIL_FROM                     = var.app_container_env_secrets.email_from
    EMAIL_SERVER_HOST              = "smtp.gmail.com"
    EMAIL_SERVER_PORT              = "465"
    EMAIL_SERVER_USER              = var.app_container_env_secrets.email_server_user
    EMAIL_SERVER_PASSWORD          = var.app_container_env_secrets.email_server_password
    NEXT_PUBLIC_TEAM_IMPERSONATION = ""
    GOOGLE_API_CREDENTIALS         = var.app_container_google_api_credentials
    GOOGLE_LOGIN_ENABLED           = "true"
  }
}
