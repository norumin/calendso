output "app_image_digest" {
  description = "Digest of the app docker image deployed"
  value = data.aws_ecr_image.app.image_digest
}
