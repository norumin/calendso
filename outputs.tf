output "app_url" {
  description = "URL for this app"
  value       = "https://${var.domain}"
}

output "app_lb_dns_name" {
  description = "Domain name of app load balancer"
  value       = module.end.app_lb_dns_name
  sensitive   = true
}

output "app_instance_public_ip" {
  description = "Public IP of app instance"
  value       = module.app.instance_public_ip
  sensitive   = true
}

output "app_image_digest" {
  description = "Digest of the app docker image deployed"
  value       = module.provision.app_image_digest
}

output "db_endpoint" {
  description = "Endpoint of the database"
  value       = module.data.db_endpoint
  sensitive   = true
}
