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
  default     = "provision"
}

variable "stage" {
  description = "Stage of deployment"
  type        = string
  default     = "production"
}

variable "domain" {
  description = "Domain of this app"
  type        = string
  default     = "calendso.norumin.com"
}

variable "app_instance_public_ip" {
  description = "Public IP address of the app instance"
  type        = string
  sensitive   = true
}

variable "app_keypair_path" {
  description = "Path to keypair file for ssh connection to the app instance"
  type        = string
  sensitive   = true
}

variable "db_endpoint" {
  description = "Endpoint to connect db instance"
  type        = string
  sensitive   = true
}

variable "ecr_repo_name" {
  description = "Name of the ECR repo"
  type        = string
  sensitive   = true
}

variable "app_image_tag" {
  description = "Tag for app docker image"
  type        = string
  default     = "latest"
}

variable "app_container_count" {
  description = "Number of app containers to run"
  type        = number
  default     = 1
}

variable "app_container_name_prefix" {
  description = "Name prefix of app containers"
  type        = string
  default     = "app"
}

variable "app_container_ports" {
  description = "Ports to publish from the container to the host"
  type        = string
  default     = "80:3000"
}

variable "app_container_log_group" {
  description = "CloudWatch log group for app containers"
  type        = string
}

variable "app_container_env_secrets" {
  description = "Secret environment variables for the app container"
  type = object({
    app_instance_public_key = string
    db_username             = string
    db_password             = string
    db_name                 = string
    auth_secret             = string
    cookie_domain           = string
    cron_api_key            = string
    encryption_key          = string
    email_from              = string
    email_server_host       = string
    email_server_port       = string
    email_server_user       = string
    email_server_password   = string
    google_api_credentials  = string
  })
  sensitive = true
}
