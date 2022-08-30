variable "app_name" {
  description = "Name of this app"
  type        = string
  default     = "Norumin Scheduling System"
}

variable "app" {
  description = "URL friendly name of this app"
  type        = string
  default     = "calendso"
}

variable "module" {
  description = "Module name"
  type        = string
  default     = "builder"
}

variable "stage" {
  description = "Stage of deployment"
  type        = string
  default     = "production"
}

variable "ecr_repo_name" {
  description = "Name of the ECR repo"
  type        = string
  sensitive   = true
}

variable "build_env" {
  description = "Build-time environment variables"
  type = object({
    NEXT_PUBLIC_LICENSE_CONSENT = string
    NEXT_PUBLIC_WEBAPP_URL      = string
    NEXT_PUBLIC_APP_URL         = string
    NEXTAUTH_SECRET             = string
    CALENDSO_ENCRYPTION_KEY     = string
    CALCOM_TELEMETRY_DISABLED   = string
  })
  sensitive = true
}
