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
  default     = "log"
}

variable "stage" {
  description = "Stage of deployment"
  type        = string
  default     = "production"
}
