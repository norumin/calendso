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

variable "app_instance_public_key" {
  description = "SSH public key for the app instance"
  type        = string
  sensitive   = true
}

variable "calendso_ref" {
  description = "Ref of calendso to deploy"
  type        = string
  default     = "v1.9.1"
}
