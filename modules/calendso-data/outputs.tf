output "db_endpoint" {
  description = "Endpoint to connect db instance"
  value       = aws_db_instance.db.endpoint
}
