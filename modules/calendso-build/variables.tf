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
  default     = "build"
}

variable "stage" {
  description = "Stage of deployment"
  type        = string
  default     = "production"
}

variable "src_repo" {
  description = "Git repository of the calendso source code"
  type        = string
  default     = "https://github.com/calcom/docker.git"
}

variable "src_revision" {
  description = "Git revision of the calendso source code"
  type        = string
  default     = "HEAD"
}

variable "image_registry" {
  description = "Docker registry to push images to"
  type        = string
  default     = "ghcr.io"
}

variable "image_name" {
  description = "Docker image name to build"
  type        = string
  default     = "norumin/calendso"
}

variable "image_tag" {
  description = "Docker image tag to build"
  type        = string
  default     = "latest"
}

variable "domain" {
  description = "Domain of this app"
  type        = string
  default     = "calendso.norumin.com"
}

variable "app_container_env_secrets" {
  description = "Environment secrets of app container"
  type = object({
    db_username            = string
    db_password            = string
    db_name                = string
    auth_secret            = string
    cookie_domain          = string
    cron_api_key           = string
    encryption_key         = string
    email_from             = string
    email_server_user      = string
    email_server_password  = string
    google_api_credentials = string
  })
  sensitive = true
}

variable "db_endpoint" {
  description = "Endpoint to connect db instance"
  type        = string
  sensitive   = true
}
