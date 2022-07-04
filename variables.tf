variable "AWS_REGION" {
  description = "AWS default region"
  type        = string
  default     = "us-east-2"
}

variable "REPO_ORIGIN" {
  description = "Owner repository of this project"
  type        = string
  default     = "https://github.com/norumin/calendso.git"
}

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

variable "apex_domain" {
  description = "Apex domain to host this app"
  type        = string
  default     = "norumin.com"
}

variable "domain" {
  description = "Domain of this app"
  type        = string
  default     = "calendso.norumin.com"
}

variable "alternative_domains" {
  description = "Alternative domains of this app"
  type        = list(string)
  default = [
    "cal.norumin.com",
  ]
}
