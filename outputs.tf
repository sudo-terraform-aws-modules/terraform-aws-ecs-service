output "id" {
  description = "ECS Service ID"
  value       = aws_ecs_service.service.id
}

output "name" {
  description = "ECS Service name"
  value       = aws_ecs_service.service.name
}

output "cluster" {
  description = "ECS Cluster the service belongs to"
  value       = aws_ecs_service.service.cluster
}
