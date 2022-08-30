output "app_url" {
  description = "URL for this app"
  value       = "https://${var.domain}"
}

output "app_lb_dns_name" {
  description = "Domain name of app load balancer"
  value       = module.end.app_lb_dns_name
  sensitive   = true
}

output "db_endpoint" {
  description = "Endpoint of the database"
  value       = module.data.db_endpoint
  sensitive   = true
}
