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
  default     = "thirdparty"
}

variable "stage" {
  description = "Stage of deployment"
  type        = string
  default     = "production"
}

variable "gcp_org_id" {
  description = "GCP Organization ID"
  type        = string
  sensitive   = true
}

variable "gcp_project_id" {
  description = "GCP Project ID"
  type        = string
  sensitive   = true
}
