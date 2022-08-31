output "app_image_tag" {
  description = "Tag for app docker image"
  value       = local.default_app_image_tag
}

output "app_image_http_port" {
  description = "Exposed HTTP port inside app docker image"
  value       = 3000
}
