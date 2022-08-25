output "ecr_repo_url" {
  description = "URL to the ECR repo"
  value       = aws_ecr_repository.main.repository_url
}
