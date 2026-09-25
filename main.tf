resource "aws_ecs_service" "service" {
  name                              = local.service_name
  cluster                           = var.cluster_name
  task_definition                   = var.task_definition_arn
  desired_count                     = var.desired_count
  launch_type                       = local.launch_type
  scheduling_strategy               = var.scheduling_strategy
  enable_execute_command            = var.enable_execute_command
  propagate_tags                    = var.propagate_tags
  health_check_grace_period_seconds = var.target_group_arn != null ? var.health_check_grace_period_seconds : null
  wait_for_steady_state             = var.wait_for_steady_state

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = var.assign_public_ip
  }

  dynamic "load_balancer" {
    for_each = var.target_group_arn != null ? [1] : []
    content {
      target_group_arn = var.target_group_arn
      container_name   = var.container_name
      container_port   = var.container_port
    }
  }

  dynamic "capacity_provider_strategy" {
    for_each = var.capacity_provider_name != null ? [1] : []
    content {
      capacity_provider = var.capacity_provider_name
      weight            = var.capacity_provider_weight
    }
  }

  dynamic "deployment_circuit_breaker" {
    for_each = var.enable_deployment_circuit_breaker ? [1] : []
    content {
      enable   = true
      rollback = var.enable_deployment_rollback
    }
  }

  tags = var.tags
}
