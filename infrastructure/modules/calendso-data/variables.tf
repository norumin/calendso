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
  default     = "data"
}

variable "stage" {
  description = "Stage of deployment"
  type        = string
  default     = "production"
}

variable "public_subnet_ids" {
  description = "Public subnet IDs of root VPC"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Private subnets of root VPC"
  type        = list(string)
}

variable "sg_ids" {
  description = "IDs of security groups to apply to the db instance"
  type        = list(string)
}

variable "db_instance_class" {
  description = "DB instance class (default db.t4g.micro)"
  type        = string
  default     = "db.t4g.micro"
}

variable "db_engine" {
  description = "The database engine to use (default postgres)"
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "The engine version to use (default 13.6)"
  type        = string
  default     = "13.6"
}

variable "db_allocated_storage" {
  description = "Allocated storage size of DB instance"
  type        = number
  default     = 5
}

variable "db_max_allocated_storage" {
  description = "Maximum allocated storage size allowed of DB instance"
  type        = number
  default     = 18
}

variable "db_username" {
  description = "Username for the master DB user"
  type        = string
  default     = "calendso"
  sensitive   = true
}

variable "db_password" {
  description = "Password for the master DB user"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "The name of the database to create when the DB instance is provisioned"
  type        = string
  default     = "calendso"
}

variable "db_publicly_accessible" {
  description = "If the database instance is accessible from Internet"
  type        = bool
  default     = false
}
