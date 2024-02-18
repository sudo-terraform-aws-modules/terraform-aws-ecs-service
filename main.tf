
resource "aws_ecs_service" "service" {
  name                   = local.service_name
  cluster                = var.cluster_name
  task_definition        = var.task_definition_arn
  desired_count          = var.desired_count
  launch_type            = local.launch_type
  enable_execute_command = var.enable_execute_command
  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  capacity_provider_strategy {
    capacity_provider = var.capacity_provider_name
    weight            = var.capacity_provider_weight
  }
}
